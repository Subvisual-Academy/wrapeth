defmodule Subscriber do
  use GenServer

  use Wrapeth.Provider, otp_app: :eth_provider

  alias EthWebSocket.WebsocketManager

  def add_sub do
    GenServer.start_link(__MODULE__, :ok)
  end

  @impl true
  def init(:ok) do
    {:ok, sub_id} =
      eth_subscribe()
      |> IO.inspect()

    {:ok, %{count: 0, sub_id: sub_id}}
  end

  @impl true
  def handle_info({:ok, _data}, state) do
    IO.puts("Subscribers:")
    IO.inspect(WebsocketManager.get_state())
    IO.inspect(state.count)

    new_state =
      if state.count > 2 do
        eth_unsubscribe(state.sub_id)
        state
      else
        Map.put(state, :count, state.count + 1)
      end

    {:noreply, new_state}
  end
end
