defmodule Subscriber do
  use Wrapeth.Provider, otp_app: :eth_provider

  alias EthWebSocket.Server

  def start_server do
    Server.start_server()
  end

  def add_sub(server_pid) do
    spawn(__MODULE__, :subscribe_and_loop, [server_pid])
  end

  def subscribe_and_loop(server_pid) do
    {:ok, sub_id} = eth_subscribe(server_pid)
    IO.inspect(sub_id)
    loop(server_pid, sub_id, 1)
  end

  def loop(server_pid, sub_id, counter) do
    receive do
      {:ok, _result} ->
        IO.puts("message received")
        # IO.inspect(result)
        Server.get_state(server_pid)
        |> IO.inspect()

        if counter < 4 do
          loop(server_pid, sub_id, counter + 1)
        else
          eth_unsubscribe(sub_id, server_pid)
          |> IO.inspect()

          Server.get_state(server_pid)
          |> IO.inspect()
        end

      _ ->
        IO.puts("bad response!!")
    end
  end
end
