defmodule Wrapeth.Provider.Interface do
  alias Wrapeth.Provider.Behaviour

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @behaviour Behaviour

      @otp_app opts[:otp_app]
      @app_name opts[:app_name]

      def get_module_and_url() do
        config = Application.get_env(@app_name, @otp_app)

        case config[:client_type] do
          :http -> {Ethereumex.HttpClient, config[:node_url]}
          :ipc -> {Ethereumex.IpcClient, config[:ipc_path]}
          _ -> {:error, :invalid_client_type}
        end
      end

      def get_accounts() do
        {module_name, node_url} = get_module_and_url()
        {:ok, accounts} = module_name.eth_accounts(url: node_url)
        accounts
      end

      def get_balance(address, block \\ "latest") do
        {module_name, node_url} = get_module_and_url()
        {:ok, balance} = module_name.eth_get_balance(address, block, url: node_url)
        balance
      end

      def get_block_number() do
        {module_name, node_url} = get_module_and_url()
        {:ok, block_number} = module_name.eth_block_number(url: node_url)
        block_number
      end

      def get_block_by_number(number, full) do
        {module_name, node_url} = get_module_and_url()
        {:ok, block} = module_name.eth_get_block_by_number(number, full, url: node_url)
        block
      end

      def get_transaction_count(address, block \\ "latest") do
        {module_name, node_url} = get_module_and_url()
        {:ok, tx_count} = module_name.eth_get_transaction_count(address, block, url: node_url)
        tx_count
      end

      def get_block_transaction_count_by_number(block \\ "latest") do
        {module_name, node_url} = get_module_and_url()
        {:ok, tx_count} =
          module_name.eth_get_block_transaction_count_by_number(block, url: node_url)
          tx_count
      end

      def get_gas_price() do
        {module_name, node_url} = get_module_and_url()
        {:ok, gas} =
          module_name.eth_gas_price(url: node_url)
          gas
      end

      def get_transaction_receipt(hash) do
        {module_name, node_url} = get_module_and_url()
        {:ok, receipt} =
          module_name.eth_get_transaction_receipt(hash,url: node_url)
          receipt
      end
    end
  end
end
