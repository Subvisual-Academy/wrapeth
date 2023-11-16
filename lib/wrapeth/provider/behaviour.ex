defmodule Wrapeth.Provider.Behaviour do
  @type error :: {:error, map() | binary() | atom()}
  @type address :: String.t()
  @type hex_value :: String.t()

  # I haven't tested these ones yet.
  @callback eth_fee_history(any(), any(), any(), any()) :: any()
  @callback eth_get_storage_at(any(), any(), any(), any()) :: any()
  @callback eth_get_block_transaction_count_by_hash(any(), any()) :: any()
  @callback eth_get_uncle_count_by_block_hash(any(), any()) :: any()
  @callback eth_get_uncle_count_by_block_number(any(), any()) :: any()
  @callback eth_get_code(any(), any(), any()) :: any()
  @callback eth_call(any(), any(), any()) :: any()
  @callback eth_estimate_gas(any(), any()) :: any()
  @callback eth_get_block_by_hash(any(), any(), any()) :: any()
  @callback eth_get_transaction_by_hash(any(), any()) :: any()
  @callback eth_get_transaction_by_block_hash_and_index(any(), any(), any()) :: any()
  @callback eth_get_transaction_by_block_number_and_index(any(), any(), any()) :: any()
  @callback eth_get_uncle_by_block_hash_and_index(any(), any(), any()) :: any()

  # API methods
  @callback eth_accounts(any()) :: {:ok, map()}
  @callback eth_block_number(any()) :: {:ok, hex_value()}
  @callback eth_get_balance(address, String.t(), any()) :: {:ok, hex_value()}
  @callback eth_get_block_by_number(hex_value(), boolean(), any()) :: {:ok, map()}
  @callback eth_get_transaction_count(address(), hex_value(), any()) :: {:ok, hex_value()}
  @callback eth_get_block_transaction_count_by_number(hex_value(), any()) :: {:ok, hex_value()}
  @callback eth_gas_price(any()) :: {:ok, hex_value()}
  @callback eth_get_transaction_receipt(hex_value(), any()) :: {:ok, map()}
  @callback net_listening(any()) :: {:ok, boolean()}
  @callback eth_protocol_version(any()) :: {:ok, hex_value()}
  @callback eth_syncing(any()) :: {:ok, map() | boolean()}
  @callback eth_max_priority_fee_per_gas(any()) :: {:ok, hex_value()}
  @callback net_version(any()) :: {:ok, String.t()}
  @callback web3_client_version(any()) :: {:ok, String.t()}
  @callback web3_sha3(hex_value(), any()) :: {:ok, hex_value()}
  @callback eth_subscribe(String.t()) :: {:ok, hex_value()}
  @callback eth_unsubscribe(hex_value) :: {:ok, hex_value()}

  # Unsupported methods
  @callback eth_mining(any()) :: any()
  @callback eth_hashrate(any()) :: any()
  @callback net_peer_count(any()) :: any()
  @callback eth_get_compilers(any()) :: any()
end
