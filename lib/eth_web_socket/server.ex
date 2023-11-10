defmodule EthWebSocket.Server do
  use GenServer
  alias EthWebSocket.Client
  @time_out 60_000

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    {:ok,
     %{
       requests: 0,
       new_heads: %{request_id: nil, sub: [], subscription_id: nil},
       new_pending_transactions: %{request_id: nil, sub: [], subscription_id: nil}
     }}
  end

  def start_server do
    {:ok, pid} = start_link()
    init_ws(pid)
    pid
  end

  def init_ws(pid) do
    GenServer.call(pid, {:init_ws, pid})
  end

  def request("eth_subscribe", ["newPendingTransactions"], pid) do
    handle_sub_request(pid, ["newPendingTransactions"], :new_pending_transactions)
  end

  def request("eth_subscribe", params, pid) do
    handle_sub_request(pid, params, :new_heads)
  end

  def request("eth_unsubscribe", params, pid) do
    state = get_state(pid)

    sub_atom = get_sub_atom(state, List.first(params), :subscription_id)

    subs = state[sub_atom]

    case length(subs[:sub]) do
      n when n > 1 ->
        GenServer.call(pid, {:unsubscribe, sub_atom})
        {:ok, true}

      1 ->
        id = state[:requests]
        GenServer.call(pid, :increment_request_count)
        {:ok, body} = add_request_info("eth_unsubscribe", params, id)
        GenServer.call(pid, {:unsubscribe, sub_atom})
        GenServer.call(pid, {:clean_sub_id, sub_atom})
        send(pid, {:perform_asynchronous_request, body})
        GenServer.call(pid, :wait_for_answer, @time_out)

      _ ->
        {:ok, false}
    end
  end

  def request(method_name, params, pid) do
    id = get_state(pid)[:requests]
    GenServer.call(pid, :increment_request_count)
    {:ok, body} = add_request_info(method_name, params, id)
    send(pid, {:perform_asynchronous_request, body})

    GenServer.call(pid, :wait_for_answer, @time_out)
  end

  def handle_sub_request(pid, params, sub_atom) do
    state = get_state(pid)
    subs = state[sub_atom]

    case is_nil(subs[:subscription_id]) do
      false ->
        GenServer.call(pid, {:subscribe, sub_atom})
        {:ok, subs[:subscription_id]}

      true ->
        id = state[:requests]
        GenServer.call(pid, :increment_request_count)
        GenServer.call(pid, {:set_sub_id, id, sub_atom})
        GenServer.call(pid, {:subscribe, sub_atom})
        {:ok, body} = add_request_info("eth_subscribe", params, id)
        send(pid, {:perform_asynchronous_request, body})
        GenServer.call(pid, :wait_for_answer, @time_out)
    end
  end

  defp add_request_info(method_name, params, id) do
    %{}
    |> Map.put("id", id)
    |> Map.put("method", method_name)
    |> Map.put("jsonrpc", "2.0")
    |> Map.put("params", params)
    |> JSON.encode()
  end

  defp get_sub_atom(state, id, search_atom) do
    head = state[:new_heads][search_atom]
    new_pending_transactions = state[:new_pending_transactions][search_atom]

    case id do
      ^head ->
        :new_heads

      ^new_pending_transactions ->
        :new_pending_transactions

      _ ->
        :not_sub
    end
  end

  def process_result(result, state) do
    params = result["params"]

    sub_atom = get_sub_atom(state, params["subscription"], :subscription_id)

    for id <- state[sub_atom][:sub] do
      send(id, {:ok, params["result"]})
    end

    state
  end

  def process_normal_reply(result, id, state) do
    sub_atom = get_sub_atom(state, id, :request_id)

    case sub_atom do
      :not_sub ->
        state

      _ ->
        updated_subs =
          Map.update!(state[sub_atom], :subscription_id, fn _ -> result end)

        Map.update!(state, sub_atom, fn _ -> updated_subs end)
    end
  end

  def get_state(pid) do
    GenServer.call(pid, :get_state)
  end

  def handle_info({:perform_asynchronous_request, body}, state) do
    WebSockex.send_frame(state.ws_pid, {:text, body})

    {:noreply, state}
  end

  def handle_info({:asynchronous_request_response, res}, state) do
    decoded_res = JSON.decode!(res)

    new_state =
      case decoded_res do
        %{"id" => id, "jsonrpc" => "2.0", "result" => result} ->
          GenServer.reply(state.from_pid, {:ok, decoded_res["result"]})
          process_normal_reply(result, id, state)

        %{"jsonrpc" => "2.0", "method" => "eth_subscription", "params" => _params} ->
          process_result(decoded_res, state)

        _ ->
          state
      end

    {:noreply, new_state}
  end

  def handle_call(:wait_for_answer, from, state) do
    new_state = Map.merge(state, %{from_pid: from})

    {:noreply, new_state}
  end

  def handle_call({:init_ws, gs_pid}, _from, state) do
    {:ok, ws_pid} = Client.start_link(%{gs_pid: gs_pid})
    new_state = Map.put(state, :ws_pid, ws_pid)
    new_state = Map.put(new_state, :gs_pid, gs_pid)

    {:reply, new_state, new_state}
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:subscribe, sub_atom}, from, state) do
    {pid, _} = from

    new_state =
      case Enum.member?(state[sub_atom][:sub], pid) do
        false ->
          updated_subs =
            Map.update!(state[sub_atom], :sub, fn _ -> [pid | state[sub_atom][:sub]] end)

          Map.update!(state, sub_atom, fn _ -> updated_subs end)

        true ->
          state
      end

    {:reply, new_state, new_state}
  end

  def handle_call({:unsubscribe, sub_atom}, from, state) do
    {pid, _} = from

    new_state =
      case Enum.member?(state[sub_atom][:sub], pid) do
        true ->
          updated_subs =
            Map.update!(state[sub_atom], :sub, fn _ ->
              Enum.filter(state[sub_atom][:sub], fn x -> x != pid end)
            end)

          Map.update!(state, sub_atom, fn _ -> updated_subs end)

        false ->
          state
      end

    {:reply, new_state, new_state}
  end

  def handle_call({:clean_sub_id, sub_atom}, _from, state) do
    updated_subs = Map.update!(state[sub_atom], :subscription_id, fn _ -> nil end)
    updated_subs = Map.update!(updated_subs, :request_id, fn _ -> nil end)
    new_state = Map.update!(state, sub_atom, fn _ -> updated_subs end)
    {:reply, new_state, new_state}
  end

  def handle_call(:increment_request_count, _from, state) do
    new_state = Map.update!(state, :requests, fn _ -> state[:requests] + 1 end)
    {:reply, new_state, new_state}
  end

  def handle_call({:set_sub_id, id, sub_atom}, _from, state) do
    updated_subs = Map.update!(state[sub_atom], :request_id, fn _ -> id end)
    new_state = Map.update!(state, sub_atom, fn _ -> updated_subs end)
    {:reply, new_state, new_state}
  end
end
