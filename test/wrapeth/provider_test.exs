defmodule Wrapeth.ProviderTest do
  use ExUnit.Case, async: true

  import Mox

  # Make sure mocks are verified when the test exits
  setup :verify_on_exit!

  test "gets block number" do
    Wrapeth.Provider
    |> expect(:call_client, fn _ -> {:ok, "0x123"} end)

    assert Wrapeth.Provider.get_block_number() ==
             "0x123"
  end
end
