defmodule Wrapeth.EthClient do
  use Wrapeth.Client
  @behaviour Wrapeth.Client

  @impl Wrapeth.Client
  @spec get_config() :: %{client_type: atom(), node_url: String.t()}
  def get_config() do
    Application.get_env(:wrapeth, :eth_client)
  end
end
