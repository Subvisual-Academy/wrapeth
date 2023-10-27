defmodule EthWebSocket.Client do
  use WebSockex
  require Logger


  def start_link(opts \\ []) do
    WebSockex.start_link(System.get_env("ETH_WEB_SOCKET"), __MODULE__, %{}, opts)
  end


  def handle_frame({:text, msg}, state) do
    Logger.info("#{msg}")
    #new_state = Map.put(state, :value, msg)

    {:reply, {:text, msg}, state}
  end

  # def handle_frame({:text, msg}, state) do
  #   Logger.info("#{msg}")
  #   #new_state = Map.put(state, :value, msg)
  #   {:ok, state}
  # end

  def handle_disconnect(%{reason: reason}, state) do
    Logger.info("Disconnect with reason: #{reason}")
    {:ok, state}
  end


end
