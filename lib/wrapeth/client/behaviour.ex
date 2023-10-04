defmodule Wrapeth.Client.Behaviour do
  @type error :: {:error, map() | binary() | atom()}

  # API methods

  @callback get_client_type() :: atom() | error
  @callback get_client() :: any() | error
end
