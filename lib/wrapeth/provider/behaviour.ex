defmodule Wrapeth.Provider.Behaviour do
  @type error :: {:error, map() | binary() | atom()}
  @type address :: String.t()
  @type hex_value :: String.t()

  # API methods
  @callback get_module_and_url() :: map() | error()
  @callback get_accounts() :: any()
  @callback get_block_number() :: hex_value()
  @callback get_balance(address, String.t()) :: hex_value()
  @callback get_block_by_number(hex_value(), boolean()) :: map()
  @callback get_transaction_count(address(), hex_value()) :: hex_value()
  @callback get_block_transaction_count_by_number(hex_value()) :: hex_value()
  @callback get_gas_price() :: hex_value()
end
