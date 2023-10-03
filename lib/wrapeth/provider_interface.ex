defmodule Wrapeth.ProviderInterface do
  @callback get_config() :: %{client_type: atom(), node_url: String.t()}




  defmacro __using__(_) do
    quote do


      def get_block_number() do
        config = get_config()
        node_url = config[:node_url]
        {:ok, block_number} = Ethereumex.HttpClient.eth_block_number(url: node_url)
        block_number
      end

      def get_balance(address, block \\ "latest") do
        config = get_config()
        node_url = config[:node_url]
        {:ok, balance} = Ethereumex.HttpClient.eth_get_balance(address, block, url: node_url)
        balance
      end

    end
  end
end
