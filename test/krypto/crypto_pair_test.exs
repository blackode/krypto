defmodule Krypto.CoinPairTest do
  use ExUnit.Case

  test "" do
    coin_pair = "btcusdt"
    Krypto.CoinPair.process(%{"s" => coin_pair, "c" => "100.0"})
    Krypto.CoinPair.process(%{"s" => coin_pair, "c" => "200.0"})
    assert Krypto.CoinPair.get_average(coin_pair) == {:ok, 150.0}
  end
end
