defmodule WsProvider do
  use Wrapeth.Provider, otp_app: :eth_provider

  def get_latest_block_number(pid) do
    block_number = eth_block_number(pid)
    block_number
  end
end
