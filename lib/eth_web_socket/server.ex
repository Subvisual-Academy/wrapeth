defmodule EthWebSocket.Server do
  use GenServer

  alias EthWebSocket.Client

  @time_out 60_000


  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    {:ok, %{ subs: %{sub: [], subscription_id: nil}}}
  end

  def start_server do
    {:ok, pid} = start_link()
    init_ws(pid)
    pid
  end

  def init_ws(pid) do

    GenServer.call(pid, {:init_ws, pid})
  end

  def request("eth_subscribe", params, pid) do
    subs = get_state(pid)[:subs]
    case is_nil(subs[:subscription_id]) do
      false ->
        GenServer.call(pid, :subscribe)
        subs[:subscription_id]

      true ->
        {:ok, body} = add_request_info("eth_subscribe", params)
        GenServer.call(pid, :subscribe)
        send(pid, {:perform_asynchronous_request, body})

        GenServer.call(pid, :wait_for_answer, @time_out)
    end
  end

  def request("eth_unsubscribe", params, pid) do
    subs = get_state(pid)[:subs]

    case length(subs[:sub]) do
      n when n > 1 ->
        GenServer.call(pid, :unsubscribe)
        true

      1 ->
        {:ok, body} = add_request_info("eth_unsubscribe", params)
        GenServer.call(pid, :unsubscribe)
        GenServer.call(pid, :clean_sub_id)
        send(pid, {:perform_asynchronous_request, body})
        GenServer.call(pid, :wait_for_answer, @time_out)

      _ ->
        false
    end
  end

  def request(method_name, params, pid) do
    {:ok, body} = add_request_info(method_name, params)
    send(pid, {:perform_asynchronous_request, body})

    GenServer.call(pid, :wait_for_answer, @time_out)
  end

  defp add_request_info(method_name, params) do
    %{}
    |> Map.put("id", 1)
    |> Map.put("method", method_name)
    |> Map.put("jsonrpc", "2.0")
    |> Map.put("params", params)
    |> JSON.encode()
  end

  def process_result(result, state) do
    params = result["params"]

    new_map =
      case state[:subs][:subscription_id] do
        nil ->
          updated_subs =
            Map.update!(state[:subs], :subscription_id, fn _ -> params["subscription"] end)

          Map.update!(state, :subs, fn _ -> updated_subs end)

        _ ->
          state
      end

    for id <- state[:subs][:sub] do
      send(id, {:ok, params["result"]})
    end

    new_map
  end

  def get_state(pid) do
    GenServer.call(pid, :get_state)
  end

  def handle_info({:perform_asynchronous_request, body}, state) do
    WebSockex.send_frame(state.ws_pid, {:text, body})

    {:noreply, state}
  end

  def handle_info({:asynchronous_request_response, res}, state) do
    GenServer.reply(state.from_pid, res)
    decoded_res = JSON.decode!(res)

    new_state =
      case Map.has_key?(decoded_res, "method") do
        true ->
          process_result(decoded_res, state)

        _ ->
          Map.put(state, :result, res)
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

  def handle_call(:subscribe, from, state) do
    {pid, _} = from

    new_state =
      case Enum.member?(state[:subs][:sub], pid) do
        false ->
          updated_subs = Map.update!(state[:subs], :sub, fn _ -> [pid | state[:subs][:sub]] end)
          Map.update!(state, :subs, fn _ -> updated_subs end)

        true ->
          state
      end

    {:reply, new_state, new_state}
  end

  def handle_call(:unsubscribe, from, state) do
    {pid, _} = from
    new_state =
      case Enum.member?(state[:subs][:sub], pid) do
        true ->
          updated_subs =
            Map.update!(state[:subs], :sub, fn _ ->
              Enum.filter(state[:subs][:sub], fn x -> x != pid end)
            end)

          Map.update!(state, :subs, fn _ -> updated_subs end)

        false ->
          state
      end

    {:reply, new_state, new_state}
  end

  def handle_call(:clean_sub_id, _from, state) do
    updated_subs = Map.update!(state[:subs], :subscription_id, fn _ -> nil end)
    new_state = Map.update!(state, :subs, fn _ -> updated_subs end)
    {:reply, new_state, new_state}
  end
end
