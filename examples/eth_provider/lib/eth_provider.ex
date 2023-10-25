defmodule EthProvider do
  use Wrapeth.Provider, otp_app: :wrapeth

  def get_latest_block_number do
   {:ok, block_number} = eth_block_number()
   block_number
  end
end
