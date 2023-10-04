defmodule Wrapeth.EthClient do
  use Wrapeth.Client.BaseClient

  @behaviour Wrapeth.Client.BaseClient



  @impl Wrapeth.Client.BaseClient
  def get_config() do
    Application.get_env(:wrapeth, :eth_client)
  end


end
