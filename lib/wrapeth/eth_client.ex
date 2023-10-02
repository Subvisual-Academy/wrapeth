defmodule Wrapeth.EthClient do
  use Wrapeth.Client

  def get_config() do
    Application.get_env(:wrapeth, :eth_client)
  end
end
