defmodule EthClientTest do
  use ExUnit.Case
  doctest Wrapeth

  test "get config" do
    url = System.get_env("ETH_NODE_URL")
    expected_result = [client_type: :http, node_url: url]

    assert Wrapeth.EthClient.get_config() == expected_result
  end
end
