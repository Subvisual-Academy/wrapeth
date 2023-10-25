defmodule EthProviderTest do
  use ExUnit.Case
  doctest EthProvider

  test "greets the world" do
    assert EthProvider.hello() == :world
  end
end
