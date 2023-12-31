defmodule Wrapeth.ProviderTest do
  use ExUnit.Case, async: true
  import Mox

  setup do
    [
      valid_address: "0x4Bd040d48fdD1C667fcE5fdDd326681766E6ad91",
      invalid_address: "0y4Bd040d48fdD1C667fcE5fdDd326681766E6ad91",
      invalid_block_number: "0y9710d"
    ]
  end

  defmodule TestProvider do
    use Wrapeth.Provider, otp_app: :wrapeth
  end

  # Make sure mocks are verified when the test exits
  setup :verify_on_exit!

  test "gets accounts", %{valid_address: valid_address} do
    HttpMock
    |> expect(:eth_accounts, fn _ -> {:ok, [valid_address]} end)

    assert TestProvider.eth_accounts() == {:ok, [valid_address]}
  end

  test "gets account balance", %{valid_address: valid_address} do
    HttpMock
    |> expect(:eth_get_balance, fn _some_addr, _, _ -> {:ok, "0x123"} end)

    assert TestProvider.eth_get_balance(valid_address) == {:ok, "0x123"}
  end

  test "gets block by number" do
    HttpMock
    |> expect(:eth_get_block_by_number, fn _some_block_number, _, _ -> {:ok, "0x123"} end)

    assert TestProvider.eth_get_block_by_number("some_block_number", true) == {:ok, "0x123"}
  end

  test "gets transaction count" do
    HttpMock
    |> expect(:eth_get_transaction_count, fn _some_addr, _, _ -> {:ok, "0x123"} end)

    assert TestProvider.eth_get_transaction_count("some_address", "latest") == {:ok, "0x123"}
  end

  test "gets transaction count by number" do
    HttpMock
    |> expect(:eth_get_block_transaction_count_by_number, fn _block, _ -> {:ok, "0x123"} end)

    assert TestProvider.eth_get_block_transaction_count_by_number("latest") == {:ok, "0x123"}
  end

  test "gets block number" do
    HttpMock
    |> expect(:eth_block_number, fn _ -> {:ok, "0x123"} end)

    assert TestProvider.eth_block_number() == {:ok, "0x123"}
  end

  test "gets gas price" do
    HttpMock
    |> expect(:eth_gas_price, fn _ -> {:ok, "0x123"} end)

    assert TestProvider.eth_gas_price() == {:ok, "0x123"}
  end

  test "gets transaction receipt" do
    HttpMock
    |> expect(:eth_get_transaction_receipt, fn _tx, _ -> {:ok, {"0x123"}} end)

    assert TestProvider.eth_get_transaction_receipt("tx_hash") == {:ok, {"0x123"}}
  end

  test "error get balance invalid address", %{invalid_address: invalid_address} do
    HttpMock
    |> expect(:eth_get_balance, fn _invalid_addr, _, _ ->
      {:error, "invalid 1st argument: address value was not a valid hexadecimal"}
    end)

    assert TestProvider.eth_get_balance(invalid_address) ==
             {:error, "invalid 1st argument: address value was not a valid hexadecimal"}
  end

  test "error get block by number with an invalid block number", %{
    invalid_block_number: invalid_block_number
  } do
    HttpMock
    |> expect(:eth_get_block_by_number, fn _invalid_block_num, _, _ ->
      {:error,
       "invalid 1st argument: block_number value was not a valid block tag or block number"}
    end)

    assert TestProvider.eth_get_block_by_number(invalid_block_number, true) ==
             {:error,
              "invalid 1st argument: block_number value was not a valid block tag or block number"}
  end
end
