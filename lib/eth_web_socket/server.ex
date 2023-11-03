defmodule Server do
  use GenServer


  @time_out 60_000

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    {:ok, %{subscribe: []}}
  end

  def start_server do
    {:ok, pid} = start_link()
    init_ws(pid)
    pid
  end

  def init_ws(pid) do
    GenServer.call(pid, {:init_ws, pid})
  end


  def request(body, pid) do
    send(pid, {:perform_asynchronous_request, body})

    GenServer.call(pid, :wait_for_answer, @time_out)
  end

  def process_result(result, state) do
    params = result["params"]
    subscribe = state[:subscribe]
    new_subs = subscribe ++ [params["result"]]
    Map.put(state, :subscribe, new_subs)
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
        true -> process_result(decoded_res, state)
        _ -> Map.put(state, :result, res)
      end

    {:noreply, new_state}
  end

  def handle_call(:wait_for_answer, from, state) do
    new_state = Map.merge(state, %{from_pid: from})

    {:noreply, new_state}
  end

  def handle_call({:init_ws, gs_pid}, _from, state) do
    IO.inspect(gs_pid)
    {:ok, ws_pid} = Client.start_link(%{gs_pid: gs_pid})
    new_state = Map.put(state, :ws_pid, ws_pid)
    new_state = Map.put(new_state, :gs_pid, gs_pid)

    {:reply, new_state, new_state}
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end
end
