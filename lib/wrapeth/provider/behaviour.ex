defmodule Wrapeth.Provider.Behaviour do
  @type error :: {:error, map() | binary() | atom()}
  @type address :: String.t()
  @type hex_value :: String.t()

  # I haven't tested these ones yet.
  @callback eth_fee_history(any(), any(), any(), pid()) :: any()
  @callback eth_get_storage_at(any(), any(), any(), pid()) :: any()
  @callback eth_get_block_transaction_count_by_hash(any(), pid()) :: any()
  @callback eth_get_uncle_count_by_block_hash(any(), pid()) :: any()
  @callback eth_get_uncle_count_by_block_number(any(), pid()) :: any()
  @callback eth_get_code(any(), any(), pid()) :: any()
  @callback eth_call(any(), any(), pid()) :: any()
  @callback eth_estimate_gas(any(), pid()) :: any()
  @callback eth_get_block_by_hash(any(), any(), pid()) :: any()
  @callback eth_get_transaction_by_hash(any(), pid()) :: any()
  @callback eth_get_transaction_by_block_hash_and_index(any(), any(), pid()) :: any()
  @callback eth_get_transaction_by_block_number_and_index(any(), any(), pid()) :: any()
  @callback eth_get_uncle_by_block_hash_and_index(any(), any(), any()) :: pid()

  # API methods
  @callback eth_accounts(pid()) :: {:ok, map()}
  @callback eth_block_number(pid()) :: {:ok, hex_value()}
  @callback eth_get_balance(address, String.t(), pid()) :: {:ok, hex_value()}
  @callback eth_get_block_by_number(hex_value(), boolean(), pid()) :: {:ok, map()}
  @callback eth_get_transaction_count(address(), hex_value(), pid()) :: {:ok, hex_value()}
  @callback eth_get_block_transaction_count_by_number(hex_value(), pid()) :: {:ok, hex_value()}
  @callback eth_gas_price(pid()) :: {:ok, hex_value()}
  @callback eth_get_transaction_receipt(hex_value(), pid()) :: {:ok, map()}
  @callback net_listening(pid()) :: {:ok, boolean()}
  @callback eth_protocol_version(pid()) :: {:ok, hex_value()}
  @callback eth_syncing(pid()) :: {:ok, map() | boolean()}
  @callback eth_max_priority_fee_per_gas(pid()) :: {:ok, hex_value()}
  @callback net_version(pid()) :: {:ok, String.t()}
  @callback web3_client_version(pid()) :: {:ok, String.t()}
  @callback web3_sha3(hex_value(), pid()) :: {:ok, hex_value()}
  @callback eth_subscribe(String.t(), pid()) :: {:ok, hex_value()}
  @callback eth_unsubscribe(hex_value, pid()) :: {:ok, hex_value()}

  # Unsupported methods
  @callback eth_mining(pid()) :: any()
  @callback eth_hashrate(pid()) :: any()
  @callback net_peer_count(pid()) :: any()
  @callback eth_get_compilers(pid()) :: any()
end
