defmodule Wrapeth.Provider do
  alias Wrapeth.Provider.Behaviour
  alias EthWebSocket.Server

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
        :eth_block_number => "eth_blockNumber",
        :eth_get_balance => "eth_getBalance",
        :eth_subscribe => "eth_subscribe",
        :eth_unsubscribe => "eth_unsubscribe"
      }

      @impl true
      def web3_client_version(pid \\ nil, _args \\ []) do
        call_client(:web3_client_version, [], pid)
      end

      @impl true
      def web3_sha3(data, pid \\ nil, _args \\ []) do
        call_client(:web3_sha3, [data])
      end

      @impl true
      def net_version(pid \\ nil, _args \\ []) do
        call_client(:net_version, [], pid)
      end

      @impl true
      def net_peer_count(pid \\ nil, _args \\ []) do
        call_client(:net_peer_count, [], pid)
      end

      @impl true
      def net_listening(pid \\ nil, _args \\ []) do
        call_client(:net_listening, [], pid)
      end

      @impl true
      def eth_protocol_version(pid \\ nil, _args \\ []) do
        call_client(:eth_protocol_version, [], pid)
      end

      @impl true
      def eth_syncing(pid \\ nil, _args \\ []) do
        call_client(:eth_syncing, [], pid)
      end

      @impl true
      def eth_mining(pid \\ nil, _args \\ []) do
        call_client(:eth_mining, [], pid)
      end

      @impl true
      def eth_hashrate(pid \\ nil, _args \\ []) do
        call_client(:eth_hashrate, [], pid)
      end

      @impl true
      def eth_max_priority_fee_per_gas(pid \\ nil, _args \\ []) do
        call_client(:eth_max_priority_fee_per_gas, [], pid)
      end

      @impl true
      def eth_fee_history(block_count, newestblock, reward_percentiles, pid \\ nil, _args \\ []) do
        call_client(:eth_fee_history, [block_count, newestblock, reward_percentiles])
      end

      @impl true
      def eth_get_storage_at(address, position, block \\ "latest", pid \\ nil, _args \\ []) do
        call_client(:eth_get_storage_at, [address, position, block])
      end

      @impl true
      def eth_get_block_transaction_count_by_hash(hash, pid \\ nil, _args \\ []) do
        call_client(:eth_get_block_transaction_count_by_hash, [hash])
      end

      @impl true
      def eth_get_block_transaction_count_by_number(block \\ "latest", pid \\ nil, _args \\ []) do
        call_client(:eth_get_block_transaction_count_by_number, [block])
      end

      @impl true
      def eth_get_uncle_count_by_block_hash(hash, pid \\ nil, _args \\ []) do
        call_client(:eth_get_uncle_count_by_block_hash, [hash])
      end

      @impl true
      def eth_get_uncle_count_by_block_number(block \\ "latest", pid \\ nil, _args \\ []) do
        call_client(:eth_get_uncle_count_by_block_number, [block])
      end

      @impl true
      def eth_get_code(address, block \\ "latest", pid \\ nil, _args \\ []) do
        call_client(:eth_get_code, [address, block])
      end

      @impl true
      def eth_call(transaction, block \\ "latest", pid \\ nil, _args \\ []) do
        call_client(:eth_call, [transaction, block])
      end

      @impl true
      def eth_estimate_gas(transaction, pid \\ nil, _args \\ []) do
        call_client(:eth_estimate_gas, [transaction])
      end

      @impl true
      def eth_get_block_by_hash(hash, full, pid \\ nil, _args \\ []) do
        call_client(:eth_get_block_by_hash, [hash, full])
      end

      @impl true
      def eth_get_transaction_by_hash(hash, pid \\ nil, _args \\ []) do
        call_client(:eth_get_transaction_by_hash, [hash])
      end

      @impl true
      def eth_get_transaction_by_block_hash_and_index(hash, index, pid \\ nil, _args \\ []) do
        call_client(:eth_get_transaction_by_block_hash_and_index, [hash, index])
      end

      @impl true
      def eth_get_transaction_by_block_number_and_index(block, index, pid \\ nil, _args \\ []) do
        call_client(:eth_get_transaction_by_block_number_and_index, [block, index])
      end

      @impl true
      def eth_get_uncle_by_block_hash_and_index(hash, index, pid \\ nil, _args \\ []) do
        call_client(:eth_get_uncle_by_block_hash_and_index, [hash, index])
      end

      @impl true
      def eth_get_compilers(pid \\ nil, _args \\ []) do
        call_client(:eth_get_compilers, [], pid)
      end

      @impl true
      def eth_accounts(pid \\ nil, _args \\ []) do
        call_client(:eth_accounts, [], pid)
      end

      @impl true
      def eth_get_balance(address, block \\ "latest", pid \\ nil, _args \\ []) do
        call_client(:eth_get_balance, [address, block], pid)
      end

      @impl true
      def eth_block_number(block \\ "latest", pid \\ nil, _args \\ []) do
        call_client(:eth_block_number, [block], pid)
      end

      @impl true
      def eth_get_block_by_number(number, full, pid \\ nil, _args \\ []) do
        call_client(:eth_get_block_by_number, [number, full])
      end

      @impl true
      def eth_get_transaction_count(address, block \\ "latest", pid \\ nil, _args \\ []) do
        call_client(:eth_get_transaction_count, [address, block])
      end

      @impl true
      def eth_gas_price(pid \\ nil, _args \\ []) do
        call_client(:eth_gas_price, [], pid)
      end

      @impl true
      def eth_get_transaction_receipt(hash, pid \\ nil, _args \\ []) do
        call_client(:eth_get_transaction_receipt, [hash])
      end

      @impl true
      def eth_subscribe(envent_type \\ "newHeads", pid, _args \\ []) do
        call_client(:eth_subscribe, [envent_type], pid)
      end

      @impl true
      def eth_unsubscribe(sub_id, pid, _args \\ []) do
        call_client(:eth_unsubscribe, [sub_id], pid)
      end

      defp call_client(method_name, args \\ [], pid \\ nil, _args \\ []) do
        case @client_type do
          WebSocket -> request(@method_name_map[method_name], args, pid)
          _ -> apply(@client_type, method_name, args ++ [[{:url, @node_url}]])
        end
      end

      defp request(name, params, pid) do
        Server.request(name, params, pid)
      end
    end
  end
end
