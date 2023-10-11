defmodule EthProvider do
  use Wrapeth.Provider.BaseProvider, app_name: :wrapeth, otp_app: :eth_client
end
