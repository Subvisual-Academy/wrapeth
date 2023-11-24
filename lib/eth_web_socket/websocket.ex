defmodule EthWebSocket.Websocket do
  use WebSockex
  require Logger

  defmodule WebsocketState do
    defstruct gs_pid: nil
  end

  def start_link(gs_pid, ws_url, opts \\ []) do
    WebSockex.start_link(ws_url, __MODULE__, %WebsocketState{gs_pid: gs_pid}, opts)
  end

  def handle_frame({:text, msg}, state) do
    send(state.gs_pid, {:asynchronous_request_response, msg})
    {:ok, state}
  end

  def handle_disconnect(%{reason: reason}, state) do
    Logger.info("Disconnect with reason: #{reason}")
    {:ok, state}
  end
end
