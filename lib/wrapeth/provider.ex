defmodule Wrapeth.Provider do
  alias Wrapeth.Provider.Behaviour

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @behaviour Behaviour

      @otp_app opts[:otp_app]
      @client_type Application.compile_env(@otp_app, __MODULE__)[:client_type]

      @node_url Application.compile_env(@otp_app, __MODULE__)[:node_url]

      @impl true
      def eth_accounts(_args \\ []) do
        call_client(:eth_accounts)
      end

      @impl true
      def eth_get_balance(address, block \\ "latest", _args \\ []) do
        call_client(:eth_get_balance, [address, block])
      end

      @impl true
      def eth_block_number(_args \\ []) do
        call_client(:eth_block_number)
      end

      @impl true
      def eth_get_block_by_number(number, full, _args \\ []) do
        call_client(:eth_get_block_by_number, [number, full])
      end

      @impl true
      def eth_get_transaction_count(address, block \\ "latest", _args \\ []) do
        call_client(:eth_get_transaction_count, [address, block])
      end

      @impl true
      def eth_get_block_transaction_count_by_number(block \\ "latest", _args \\ []) do
        call_client(:eth_get_block_transaction_count_by_number, [block])
      end

      @impl true
      def eth_gas_price(_args \\ []) do
        call_client(:eth_gas_price)
      end

      @impl true
      def eth_get_transaction_receipt(hash, _args \\ []) do
        call_client(:eth_get_transaction_receipt, [hash])
      end

      defp call_client(method_name, args \\ [], _arg \\ []) do
        apply(@client_type, method_name, args ++ [[{:url, @node_url}]])
      end
    end
  end
end
