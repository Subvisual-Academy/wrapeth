defmodule Provider do


  def eth_block_number(opts \\ [], pid) do
    request("eth_blockNumber", [], opts, pid)
  end

  def eth_gas_price(opts \\ [], pid) do
    request("eth_gasPrice", [], opts, pid)
  end

  def eth_get_balance(address, block \\ "latest", opts \\ [], pid) do
    params = [address, block]

    request("eth_getBalance", params, opts, pid)
  end

  def eth_subscribe(envent_type \\ "newHeads", opts \\ [], pid) do
    params = [envent_type]

    request("eth_subscribe", params, opts, pid)
  end

  def eth_unsubscribe(subs_id, opts \\ [], pid) do
    params = [subs_id]

    request("eth_unsubscribe", params, opts, pid)
  end

  def request(name, params, _opts, pid) do
    {:ok, body} = add_request_info(name, params)
    server_request(body, pid)
  end

  defp add_request_info(method_name, params) do
    %{}
    |> Map.put("id", 1)
    |> Map.put("method", method_name)
    |> Map.put("jsonrpc", "2.0")
    |> Map.put("params", params)
    |> JSON.encode()
  end


  def server_request(body, pid) do

    result =
      Server.request(body, pid)
      |> JSON.decode!()

    result["result"]
  end
end
