defmodule Wrapeth.ProviderTest do
  use ExUnit.Case, async: true
  import Mox

  defmodule TestProvider do
    use Wrapeth.Provider, otp_app: :wrapeth
  end

  # Make sure mocks are verified when the test exits
  setup :verify_on_exit!

  test "gets accounts" do
    HttpMock
    |> expect(:eth_accounts, fn _ -> {:ok, ["0x407d73d8a49eeb85d32cf465507dd71d507100c1"]} end)

    assert TestProvider.eth_accounts() ==
             ["0x407d73d8a49eeb85d32cf465507dd71d507100c1"]
  end

  test "gets account balance" do
    HttpMock
    |> expect(:eth_get_balance, fn _some_addr, _, _ -> {:ok, "0x123"} end)

    assert TestProvider.eth_get_balance("0x407d73d8a49eeb85d32cf465507dd71d507100c1") ==
             "0x123"
  end

  test "gets block by number" do
    HttpMock
    |> expect(:eth_get_block_by_number, fn _some_block_number, _, _ -> {:ok, "0x123"} end)

    assert TestProvider.eth_get_block_by_number("some_block_number", true) ==
             "0x123"
  end

  test "gets transaction count" do
    HttpMock
    |> expect(:eth_get_transaction_count, fn _some_addr, _, _ -> {:ok, "0x123"} end)

    assert TestProvider.eth_get_transaction_count("some_address", "latest") ==
             "0x123"
  end

  test "gets transaction count by number" do
    HttpMock
    |> expect(:eth_get_block_transaction_count_by_number, fn _block, _ -> {:ok, "0x123"} end)

    assert TestProvider.eth_get_block_transaction_count_by_number("latest") ==
             "0x123"
  end

  test "gets block number" do
    HttpMock
    |> expect(:eth_block_number, fn _ -> {:ok, "0x123"} end)

    assert TestProvider.eth_block_number() ==
             "0x123"
  end

  test "gets gas price" do
    HttpMock
    |> expect(:eth_gas_price, fn _ -> {:ok, "0x123"} end)

    assert TestProvider.eth_gas_price() ==
             "0x123"
  end

  test "gets transaction receipt" do
    HttpMock
    |> expect(:eth_get_transaction_receipt, fn _tx, _ -> {:ok, {"0x123"}} end)

    assert TestProvider.eth_get_transaction_receipt("tx_hash") ==
             {"0x123"}
  end

  test "error calling client" do
    HttpMock
    |> expect(:eth_gas_price, fn _ -> {:error, "error calling the client"} end)

    assert_raise(RuntimeError, "error calling the client", fn ->
      TestProvider.eth_gas_price(:eth_gas_price)
    end)
  end
end
