defmodule Wrapeth.Provider.Interface do
  alias Wrapeth.Provider.Behaviour

  defmacro __using__(_) do
    quote do
      @behaviour Behaviour
      def web3_client_version() do
        {module_name, node_url} = client_and_url()

        case module_name.web3_client_version(url: node_url) do
          {:ok, client_version} -> client_version
          error -> error
        end
      end

      def web3_sha3(data) do
        {module_name, node_url} = client_and_url()

        case module_name.web3_sha3(data, url: node_url) do
          {:ok, sha3} -> sha3
          error -> error
        end
      end

      def net_version() do
        {module_name, node_url} = client_and_url()

        case module_name.net_version(url: node_url) do
          {:ok, version} -> version
          error -> error
        end
      end

      def net_peer_count() do
        {module_name, node_url} = client_and_url()

        case module_name.net_peer_count(url: node_url) do
          {:ok, peer_count} -> peer_count
          error -> error
        end
      end

      def net_listening() do
        {module_name, node_url} = client_and_url()

        case module_name.net_listening(url: node_url) do
          {:ok, listening} -> listening
          error -> error
        end
      end

      def eth_protocol_version() do
        {module_name, node_url} = client_and_url()

        case module_name.eth_protocol_version(url: node_url) do
          {:ok, version} -> version
          error -> error
        end
      end

      def eth_syncing() do
        {module_name, node_url} = client_and_url()

        case module_name.eth_syncing(url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_coinbase() do
        {module_name, node_url} = client_and_url()

        case module_name.eth_coinbase(url: node_url) do
          {:ok, address} -> address
          error -> error
        end
      end

      def eth_mining() do
        {module_name, node_url} = client_and_url()

        case module_name.eth_mining(url: node_url) do
          {:ok, is_mining} -> is_mining
          error -> error
        end
      end

      def eth_hashrate() do
        {module_name, node_url} = client_and_url()

        case module_name.eth_hashrate(url: node_url) do
          {:ok, quantity} -> quantity
          error -> error
        end
      end

      def eth_gas_price() do
        {module_name, node_url} = client_and_url()

        case module_name.eth_gas_price(url: node_url) do
          {:ok, gas_price} -> gas_price
          error -> error
        end
      end

      def eth_max_priority_fee_per_gas() do
        {module_name, node_url} = client_and_url()

        case module_name.eth_max_priority_fee_per_gas(url: node_url) do
          {:ok, max_fee} -> max_fee
          error -> error
        end
      end

      def eth_fee_history(block_count, newestblock, reward_percentiles) do
        {module_name, node_url} = client_and_url()

        case module_name.eth_fee_history(block_count, newestblock, reward_percentiles,
               url: node_url
             ) do
          {:ok, fee_history} -> fee_history
          error -> error
        end
      end

      def eth_accounts() do
        {module_name, node_url} = client_and_url()

        case module_name.eth_accounts(url: node_url) do
          {:ok, accounts} -> accounts
          error -> error
        end
      end

      def eth_block_number() do
        {module_name, node_url} = client_and_url()

        case module_name.eth_block_number(url: node_url) do
          {:ok, block_number} -> block_number
          error -> error
        end
      end

      def eth_get_balance(address, block \\ "latest") do
        {module_name, node_url} = client_and_url()

        case module_name.eth_get_balance(address, block, url: node_url) do
          {:ok, balance} -> balance
          error -> error
        end
      end

      def eth_get_storage_at(address, position, block \\ "latest") do
        {module_name, node_url} = client_and_url()

        case module_name.eth_eth_get_storage_at(address, position, block, url: node_url) do
          {:ok, balance} -> balance
          error -> error
        end
      end

      def eth_get_transaction_count(address, position, block \\ "latest") do
        {module_name, node_url} = client_and_url()

        case module_name.eth_get_transaction_count(address, position, block, url: node_url) do
          {:ok, count} -> count
          error -> error
        end
      end

      def eth_get_block_transaction_count_by_hash(hash) do
        {module_name, node_url} = client_and_url()

        case module_name.eth_get_block_transaction_count_by_hash(hash, url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_get_block_transaction_count_by_number(block \\ "latest") do
        {module_name, node_url} = client_and_url()

        case module_name.eth_get_block_transaction_count_by_number(block, url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_get_uncle_count_by_block_hash(hash) do
        {module_name, node_url} = client_and_url()

        case module_name.eth_get_uncle_count_by_block_hash(hash, url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_get_uncle_count_by_block_number(block \\ "latest") do
        {module_name, node_url} = client_and_url()

        case module_name.eth_get_uncle_count_by_block_number(block, url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_get_code(address, block \\ "latest") do
        {module_name, node_url} = client_and_url()

        case module_name.eth_get_code(address, block, url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_estimate_gas(transaction) do
        {module_name, node_url} = client_and_url()

        case module_name.eth_estimate_gas(transaction, url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_get_block_by_hash(hash, full) do
        {module_name, node_url} = client_and_url()

        case module_name.eth_get_block_by_hash(hash, full, url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_get_block_by_number(number, full) do
        {module_name, node_url} = client_and_url()

        case module_name.eth_get_block_by_number(number, full, url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_get_transaction_by_hash(hash) do
        {module_name, node_url} = client_and_url()

        case module_name.eth_get_transaction_by_hash(hash, url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_get_transaction_by_block_hash_and_index(hash, index) do
        {module_name, node_url} = client_and_url()

        case module_name.eth_get_transaction_by_block_hash_and_index(hash, index, url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_get_transaction_by_block_number_and_index(block, index) do
        {module_name, node_url} = client_and_url()

        case module_name.eth_get_transaction_by_block_number_and_index(block, index,
               url: node_url
             ) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_get_transaction_receipt(hash) do
        {module_name, node_url} = client_and_url()

        case module_name.eth_get_transaction_receipt(hash, url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_get_uncle_by_block_hash_and_index(hash, index) do
        {module_name, node_url} = client_and_url()

        case module_name.eth_get_uncle_by_block_hash_and_index(hash, index, url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_get_uncle_by_block_number_and_index(block, index) do
        {module_name, node_url} = client_and_url()

        case module_name.eth_get_uncle_by_block_number_and_index(block, index, url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_get_compilers() do
        {module_name, node_url} = client_and_url()

        case module_name.eth_get_compilers(url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_compile_lll(data) do
        {module_name, node_url} = client_and_url()

        case module_name.eth_compile_lll(data, url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_new_filter(data) do
        {module_name, node_url} = client_and_url()

        case module_name.eth_new_filter(data, url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_new_block_filter() do
        {module_name, node_url} = client_and_url()

        case module_name.eth_new_block_filter(url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_new_pending_transaction_filter() do
        {module_name, node_url} = client_and_url()

        case module_name.eth_new_pending_transaction_filter(url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_uninstall_filter(id) do
        {module_name, node_url} = client_and_url()

        case module_name.eth_uninstall_filter(id, url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_get_filter_changes(id) do
        {module_name, node_url} = client_and_url()

        case module_name.eth_get_filter_changes(id, url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_get_filter_logs(id) do
        {module_name, node_url} = client_and_url()

        case module_name.eth_get_filter_logs(id, url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end

      def eth_get_logs(filter) do
        {module_name, node_url} = client_and_url()

        case module_name.eth_get_logs(filter, url: node_url) do
          {:ok, value} -> value
          error -> error
        end
      end
    end
  end
end
