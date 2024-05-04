defmodule Krypto do
  @moduledoc """
  Documentation for `Krypto`.
  """
  def ticker_stream do
    %{
      "e" => "event_type",
      "E" => "event_time",
      "s" => "symbol",
      "p" => "price_change",
      "P" => "price_change_percent",
      "w" => "weighted_average_price",
      "c" => "last_price",
      "Q" => "last_quantity",
      "o" => "open_price",
      "h" => "high_price",
      "l" => "low_price",
      "v" => "total_traded_base_asset",
      "q" => "total_traded_quote_asset",
      "O" => "stat_open_time",
      "C" => "stat_close_time",
      "F" => "first_trade_id",
      "L" => "last_trade_id",
      "n" => "no_of_trades"
    }
  end

  @doc """
  Converts the ticker stream data with proper keys.
  """
  @spec to_ticker_stream(map) :: map()
  def to_ticker_stream(data) do
    ticker_stream = ticker_stream()
    Map.new(data, fn {key, value} -> {ticker_stream[key], value} end)
  end
end
