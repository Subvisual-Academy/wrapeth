defmodule Subscriber do
  use Wrapeth.Provider, otp_app: :eth_provider

  alias EthWebSocket.WebsocketManager

  def start_server do
    ws_url = Application.get_env(:eth_provider, Subscriber)[:node_url]
    WebsocketManager.start_websocket_manager_and_websocket(ws_url)
  end

  def add_sub() do
    spawn(__MODULE__, :subscribe_and_loop, [])
  end

  def subscribe_and_loop() do
    {:ok, sub_id} = eth_subscribe()
    IO.inspect(sub_id)
    loop(sub_id, 1)
  end

  def loop(sub_id, counter) do
    receive do
      {:ok, _result} ->
        IO.puts("message received")
        # IO.inspect(result)
        WebsocketManager.get_state()
        |> IO.inspect()

        if counter < 4 do
          loop(sub_id, counter + 1)
        else
          eth_unsubscribe(sub_id)
          |> IO.inspect()

          WebsocketManager.get_state()
          |> IO.inspect()
        end

      _ ->
        IO.puts("bad response!!")
    end
  end
end
