defmodule Wrapeth.Provider.ProviderInterface do
  alias Wrapeth.Provider.Behaviour

  defmacro __using__(_) do
    quote do
      @behaviour Behaviour
      def get_accounts() do
        {module_name, node_url} = client_and_url()
        {:ok, accounts} = module_name.eth_accounts(url: node_url)
        accounts
      end

      def get_block_number() do
        {module_name, node_url} = client_and_url()
        {:ok, block_number} = module_name.eth_block_number(url: node_url)
        block_number
      end

      def get_balance(address, block \\ "latest") do
        {module_name, node_url} = client_and_url()
        {:ok, balance} = module_name.eth_get_balance(address, block, url: node_url)
        balance
      end
    end
  end
end
