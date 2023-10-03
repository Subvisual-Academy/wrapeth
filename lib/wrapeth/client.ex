defmodule Wrapeth.Client do
  @callback get_config() :: %{client_type: atom(), node_url: String.t()}

  def get_config() do
    []
  end


  defmacro __using__(_) do
    quote do
      def get_block_number() do
        config = get_config()
        node_url = config[:node_url]
        {:ok, block_number} = Ethereumex.HttpClient.eth_block_number(url: node_url)
        block_number
      end
    end
  end
end
