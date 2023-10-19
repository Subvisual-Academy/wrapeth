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
        {:ok, accounts} = call_client(:eth_accounts)
        accounts
      end

      @impl true
      def eth_get_balance(address, block \\ "latest", _args \\ []) do
        {:ok, balance} = call_client(:eth_get_balance, [address, block])
        balance
      end

      @impl true
      def eth_block_number(_args \\ []) do
        {:ok, block_number} = call_client(:eth_block_number)
        block_number
      end

      @impl true
      def eth_get_block_by_number(number, full, _args \\ []) do
        {:ok, block} = call_client(:eth_get_block_by_number, [number, full])
        block
      end

      @impl true
      def eth_get_transaction_count(address, block \\ "latest", _args \\ []) do
        {:ok, tx_count} = call_client(:eth_get_transaction_count, [address, block])
        tx_count
      end

      @impl true
      def eth_get_block_transaction_count_by_number(block \\ "latest", _args \\ []) do
        {:ok, tx_count} = call_client(:eth_get_block_transaction_count_by_number, [block])

        tx_count
      end

      @impl true
      def eth_gas_price(_args \\ []) do
        {:ok, gas} = call_client(:eth_gas_price)

        gas
      end

      @impl true
      def eth_get_transaction_receipt(hash, _args \\ []) do
        {:ok, receipt} = call_client(:eth_get_transaction_receipt, [hash])

        receipt
      end

      @impl true
      def call_client(method_name, args \\ [], _arg \\ []) do
        case apply(@client_type, method_name, args ++ [[{:url, @node_url}]]) do
          {:ok, value} -> {:ok, value}
          {:error, error} -> raise(error)
        end
      end
    end
  end
end
