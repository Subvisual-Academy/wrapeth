defmodule Wrapeth.Provider do
  alias Wrapeth.Provider.Behaviour

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @behaviour Behaviour

      @otp_app opts[:otp_app]
      @impl true
      def get_accounts() do
        {:ok, accounts} = call_client(:eth_accounts)
        accounts
      end

      @impl true
      def get_balance(address, block \\ "latest") do
        {:ok, balance} = call_client(:eth_get_balance, [address, block])
        balance
      end

      @impl true
      def get_block_number() do
        {:ok, block_number} = call_client(:eth_block_number)
        block_number
      end

      @impl true
      def get_block_by_number(number, full) do
        {:ok, block} = call_client(:eth_get_block_by_number, [number, full])
        block
      end

      @impl true
      def get_transaction_count(address, block \\ "latest") do
        {:ok, tx_count} = call_client(:eth_get_transaction_count, [address, block])
        tx_count
      end

      @impl true
      def get_block_transaction_count_by_number(block \\ "latest") do
        {:ok, tx_count} = call_client(:eth_get_block_transaction_count_by_number, [block])

        tx_count
      end

      @impl true
      def get_gas_price() do
        {:ok, gas} = call_client(:eth_gas_price)

        gas
      end

      @impl true
      def get_transaction_receipt(hash) do
        {:ok, receipt} = call_client(:eth_get_transaction_receipt, [hash])

        receipt
      end

      @impl true
      def call_client(method_name, args \\ []) do
        config = Application.get_env(@otp_app, __MODULE__)

        case config[:client_type] do
          :http ->
            apply(Ethereumex.HttpClient, method_name, args ++ [[{:url, config[:node_url]}]])

          :ipc ->
            apply(Ethereumex.IpcClient, method_name, args ++ [[url: config[:ipc_path]]])

          _ ->
            {:error, :invalid_client_type}
        end
      end
    end
  end
end
