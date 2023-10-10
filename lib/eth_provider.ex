defmodule EthProvider do
  use Wrapeth.Provider.Interface, app_name: :wrapeth, otp_app: :eth_client
end
