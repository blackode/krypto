defmodule KryptoTest do
  use ExUnit.Case
  doctest Krypto

  test "greets the world" do
    assert Krypto.hello() == :world
  end
end
