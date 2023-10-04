defmodule Wrapeth.Provider.ProviderInterface do
  # @callback get_config() :: %{client_type: atom(), node_url: String.t()}

  alias Module.Types.Behaviour
  alias Wrapeth.Provider.Behaviour

  defmacro __using__(_) do
    quote do
      @behaviour Behaviour
      @impl true
      def get_accounts() do
        {module_name, node_url} = client_and_url()
        {:ok, accounts} = module_name.eth_accounts(url: node_url)
        accounts
      end

      @impl true
      def get_block_number() do
        {module_name, node_url} = client_and_url()
        {:ok, block_number} = module_name.eth_block_number(url: node_url)
        block_number
      end

      @impl true
      def get_balance(address, block \\ "latest") do
        {module_name, node_url} = client_and_url()
        {:ok, balance} = module_name.eth_get_balance(address, block, url: node_url)
        balance
      end

      @impl true
      def client_and_url() do
        config = get_config()
        config[:node_url]
        {get_client(), config[:node_url]}
      end
    end
  end
end
