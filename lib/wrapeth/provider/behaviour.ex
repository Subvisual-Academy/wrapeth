defmodule Wrapeth.Provider.Behaviour do
  @type error :: {:error, map() | binary() | atom()}
  @type address :: String.t()
  @type hex_value :: String.t()

  # API methods
  @callback eth_accounts(any()) :: any()
  @callback eth_block_number(any) :: hex_value()
  @callback eth_get_balance(address, String.t(), any()) :: hex_value()
  @callback eth_get_block_by_number(hex_value(), boolean(), any()) :: map()
  @callback eth_get_transaction_count(address(), hex_value(), any()) :: hex_value()
  @callback eth_get_block_transaction_count_by_number(hex_value(), any()) :: hex_value()
  @callback eth_gas_price(any()) :: hex_value()
  @callback eth_get_transaction_receipt(hex_value(), any()) :: map()
  @callback call_client(keyword(), [String.t() | boolean()], any()) ::
              {keyword(), map() | hex_value()}
end
