defmodule WsProvider do
  use Wrapeth.Provider, otp_app: :eth_provider

  alias EthWebSocket.Server

  def get_latest_block_number(pid) do
    block_number = eth_block_number(pid)
    block_number
  end

  def start_ws_subs do
    pid = Server.start_server()
    IO.inspect(pid)
    sub_id = eth_subscribe(pid)
    IO.inspect(sub_id)
    loop(pid, sub_id)
  end

  def loop(pid, sub_id) do
    receive do
      {:ok, _result} ->
        IO.puts("message received")

        Server.get_state(pid)
        |> IO.inspect()

        eth_unsubscribe(sub_id, pid)
        |> IO.inspect()

        Server.get_state(pid)
        |> IO.inspect()

      _ ->
        IO.puts("bad response!!")
    end
  end
end
