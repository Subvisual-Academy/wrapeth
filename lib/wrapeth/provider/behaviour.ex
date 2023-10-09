defmodule Wrapeth.Provider.Behaviour do
  @type error :: {:error, map() | binary() | atom()}
  @type address :: String.t()
  @type hex_value :: String.t()

  # API methods

  @callback get_accounts() :: any()
  @callback get_block_number() :: any()
  @callback get_balance(address, String.t()) :: hex_value()
end
