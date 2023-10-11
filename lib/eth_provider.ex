defmodule EthProvider do
  use Wrapeth.Provider, otp_app: EthClient
end
