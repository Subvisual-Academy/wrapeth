defmodule EthWebSocket.Client do
  use WebSockex
  require Logger

  def start_link(state, opts \\ []) do
    # Find a better way to get env var
    WebSockex.start_link(System.get_env("ETH_WEB_SOCKET"), __MODULE__, state, opts)
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
