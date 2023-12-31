defmodule Wrapeth.Provider do
  alias Wrapeth.Provider.Behaviour
  alias EthWebSocket.WebsocketManager

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @behaviour Behaviour

      @otp_app opts[:otp_app]
      @client_type Application.compile_env(@otp_app, __MODULE__)[:client_type]

      @node_url Application.compile_env(@otp_app, __MODULE__)[:node_url]

      unless @client_type do
        raise "Client type not defined in configuration"
      end

      unless @node_url do
        raise "Node URL not defined in configuration"
      end

      @method_name_map %{
        :eth_accounts => "eth_accounts",
        :eth_get_block_by_number => "eth_getBlockByNumber",
        :eth_get_transaction_count => "eth_getTransactionCount",
        :eth_get_block_transaction_count_by_number => "eth_getBlockTransactionCountByNumber",
        :eth_gas_price => "eth_gasPrice",
        :eth_get_transaction_receipt => "eth_getTransactionReceipt",
        :net_listening => "net_listening",
        :eth_protocol_version => "eth_protocolVersion",
        :eth_syncing => "eth_syncing",
        :eth_max_priority_fee_per_gas => "eth_maxPriorityFeePerGas",
        :net_version => "net_version",
        :web3_client_version => "web3_clientVersion",
        :web3_sha3 => "web3_sha3",
        :eth_block_number => "eth_blockNumber",
        :eth_get_balance => "eth_getBalance",
        :eth_subscribe => "eth_subscribe",
        :eth_unsubscribe => "eth_unsubscribe"
      }

      @impl true
      def web3_client_version(_args \\ []) do
        call_client(:web3_client_version, [])
      end

      @impl true
      def web3_sha3(data, _args \\ []) do
        call_client(:web3_sha3, [data])
      end

      @impl true
      def net_version(_args \\ []) do
        call_client(:net_version, [])
      end

      @impl true
      def net_peer_count(_args \\ []) do
        call_client(:net_peer_count, [])
      end

      @impl true
      def net_listening(_args \\ []) do
        call_client(:net_listening, [])
      end

      @impl true
      def eth_protocol_version(_args \\ []) do
        call_client(:eth_protocol_version, [])
      end

      @impl true
      def eth_syncing(_args \\ []) do
        call_client(:eth_syncing, [])
      end

      @impl true
      def eth_mining(_args \\ []) do
        call_client(:eth_mining, [])
      end

      @impl true
      def eth_hashrate(_args \\ []) do
        call_client(:eth_hashrate, [])
      end

      @impl true
      def eth_max_priority_fee_per_gas(_args \\ []) do
        call_client(:eth_max_priority_fee_per_gas, [])
      end

      @impl true
      def eth_fee_history(block_count, newestblock, reward_percentiles, _args \\ []) do
        call_client(:eth_fee_history, [block_count, newestblock, reward_percentiles])
      end

      @impl true
      def eth_get_storage_at(address, position, block \\ "latest", _args \\ []) do
        call_client(:eth_get_storage_at, [address, position, block])
      end

      @impl true
      def eth_get_block_transaction_count_by_hash(hash, _args \\ []) do
        call_client(:eth_get_block_transaction_count_by_hash, [hash])
      end

      @impl true
      def eth_get_block_transaction_count_by_number(block \\ "latest", _args \\ []) do
        call_client(:eth_get_block_transaction_count_by_number, [block])
      end

      @impl true
      def eth_get_uncle_count_by_block_hash(hash, _args \\ []) do
        call_client(:eth_get_uncle_count_by_block_hash, [hash])
      end

      @impl true
      def eth_get_uncle_count_by_block_number(block \\ "latest", _args \\ []) do
        call_client(:eth_get_uncle_count_by_block_number, [block])
      end

      @impl true
      def eth_get_code(address, block \\ "latest", _args \\ []) do
        call_client(:eth_get_code, [address, block])
      end

      @impl true
      def eth_call(transaction, block \\ "latest", _args \\ []) do
        call_client(:eth_call, [transaction, block])
      end

      @impl true
      def eth_estimate_gas(transaction, _args \\ []) do
        call_client(:eth_estimate_gas, [transaction])
      end

      @impl true
      def eth_get_block_by_hash(hash, full, _args \\ []) do
        call_client(:eth_get_block_by_hash, [hash, full])
      end

      @impl true
      def eth_get_transaction_by_hash(hash, _args \\ []) do
        call_client(:eth_get_transaction_by_hash, [hash])
      end

      @impl true
      def eth_get_transaction_by_block_hash_and_index(hash, index, _args \\ []) do
        call_client(:eth_get_transaction_by_block_hash_and_index, [hash, index])
      end

      @impl true
      def eth_get_transaction_by_block_number_and_index(block, index, _args \\ []) do
        call_client(:eth_get_transaction_by_block_number_and_index, [block, index])
      end

      @impl true
      def eth_get_uncle_by_block_hash_and_index(hash, index, _args \\ []) do
        call_client(:eth_get_uncle_by_block_hash_and_index, [hash, index])
      end

      @impl true
      def eth_get_compilers(_args \\ []) do
        call_client(:eth_get_compilers, [])
      end

      @impl true
      def eth_accounts(_args \\ []) do
        call_client(:eth_accounts, [])
      end

      @impl true
      def eth_get_balance(address, block \\ "latest", _args \\ []) do
        call_client(:eth_get_balance, [address, block])
      end

      @impl true
      def eth_block_number(_args \\ []) do
        call_client(:eth_block_number, [])
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
      def eth_gas_price(_args \\ []) do
        call_client(:eth_gas_price, [])
      end

      @impl true
      def eth_get_transaction_receipt(hash, _args \\ []) do
        call_client(:eth_get_transaction_receipt, [hash])
      end

      @impl true
      def eth_subscribe(envent_type \\ "newHeads") do
        call_client(:eth_subscribe, [envent_type])
      end

      @impl true
      def eth_unsubscribe(sub_id) do
        call_client(:eth_unsubscribe, [sub_id])
      end

      defp call_client(method_name, args \\ []) do
        case @client_type do
          WebSocket -> request(method_name, args)
          _ -> apply(@client_type, method_name, args ++ [[{:url, @node_url}]])
        end
      end

      defp request(name, params) do
        if @method_name_map[name] do
          WebsocketManager.request(@method_name_map[name], params)
        else
          throw("#{name} not valid method")
        end
      end
    end
  end
end
