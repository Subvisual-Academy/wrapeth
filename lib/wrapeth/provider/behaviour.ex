defmodule Wrapeth.Provider.Behaviour do
  @type error :: {:error, map() | binary() | atom()}
  @type address :: String.t()
  @type hex_value :: String.t()

  # API methods
  @callback web3_client_version() :: binary() | error
  @callback web3_sha3(binary()) :: binary() | error
  @callback net_version() :: binary() | error
  @callback net_peer_count() :: binary() | error
  @callback net_listening() :: boolean() | error
  @callback eth_protocol_version() :: binary() | error
  @callback eth_syncing() :: map() | boolean() | error
  @callback eth_coinbase() :: binary() | error
  @callback eth_mining() :: boolean() | error
  @callback eth_hashrate() :: binary() | error
  @callback eth_gas_price() :: binary() | error
  @callback eth_max_priority_fee_per_gas() :: binary() | error
  @callback eth_fee_history(binary(), binary(), list(binary())) :: map() | error
  @callback eth_accounts() :: any() | error
  @callback eth_block_number() :: hex_value() | error
  @callback eth_get_balance(binary(), binary()) :: hex_value() | error
  @callback eth_get_storage_at(binary(), binary(), binary()) :: binary() | error
  @callback eth_get_transaction_count(binary(), binary()) :: binary() | error
  @callback eth_get_block_transaction_count_by_hash(binary()) ::
              binary() | error
  @callback eth_get_block_transaction_count_by_number(binary()) ::
              binary() | error
  @callback eth_get_uncle_count_by_block_hash(binary()) :: binary() | error
  @callback eth_get_uncle_count_by_block_number(binary()) :: binary() | error
  @callback eth_get_code(binary(), binary()) :: binary() | error
  @callback eth_estimate_gas(map()) :: binary() | error
  @callback eth_get_block_by_hash(binary(), boolean()) :: map() | error
  @callback eth_get_block_by_number(binary(), boolean()) :: map() | error
  @callback eth_get_transaction_by_hash(binary()) :: map() | error
  @callback eth_get_transaction_by_block_hash_and_index(binary(), binary()) ::
              map() | error
  @callback eth_get_transaction_by_block_number_and_index(binary(), binary()) ::
              binary() | error
  @callback eth_get_transaction_receipt(binary()) :: map() | error
  @callback eth_get_uncle_by_block_hash_and_index(binary(), binary()) ::
              map() | error
  @callback eth_get_uncle_by_block_number_and_index(binary(), binary()) ::
              map() | error
  @callback eth_get_compilers() :: [binary()] | error
  @callback eth_compile_lll(binary()) :: binary() | error
  @callback eth_new_filter(map()) :: binary() | error
  @callback eth_new_block_filter() :: binary() | error
  @callback eth_new_pending_transaction_filter() :: binary() | error
  @callback eth_uninstall_filter(binary()) :: boolean() | error
  @callback eth_get_filter_changes(binary()) :: [binary()] | [map()] | error
  @callback eth_get_filter_logs(binary()) :: [binary()] | [map()] | error
  @callback eth_get_logs(map()) :: [binary()] | [map()] | error
end
