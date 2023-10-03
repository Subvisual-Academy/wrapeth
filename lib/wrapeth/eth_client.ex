defmodule Wrapeth.EthClient do
  use Wrapeth.ProviderInterface
  @behaviour Wrapeth.ProviderInterface



  @impl Wrapeth.ProviderInterface
  def get_config() do
    Application.get_env(:wrapeth, :eth_client)
  end


end
