defmodule Krypto.Binance do
  @moduledoc """
  Binance Websocket client
  """
  use WebSockex
  require Logger

  @binance_url "wss://stream.binance.com:9443/ws/stream"
  @me __MODULE__

  def start_link(_opts) do
    WebSockex.start_link(@binance_url, @me, %{}, name: @me)
  end

  @doc """
  It subscribes the given coinpairs on fly. It is coinpair insensitive.

  ## Examples

      iex> Krypto.Binance.subscribe("BTCUSDT")
      iex> Krypto.Binance.subscribe("BTCUSDT")
      iex> Krypto.Binance.subscribe("btcusdt")
      iex> Krypto.Binance.subscribe(["btcusdt"])
      iex> Krypto.Binance.subscribe(["BTCUSDT", "ethusdt"])
  """
  def subscribe(coinpairs) do
    coinpairs = List.wrap(coinpairs)
    params = Enum.map(coinpairs, &String.downcase("#{&1}@ticker"))

    payload = %{
      "id" => 1,
      "params" => params,
      "method" => "SUBSCRIBE"
    }

    send(__MODULE__, {:subscribe, Jason.encode!(payload)})
  end

  @impl true
  def handle_frame({_type, message}, state) do
    case Jason.decode(message) do
      {:error, _decoding_error} ->
        Logger.debug(inspect(message))
        state

      {:ok, %{"result" => nil}} ->
        Logger.info("No results found ")

      {:ok, data} ->
        Krypto.CoinPair.process(data)
    end

    {:ok, state}
  end

  @impl true
  def handle_info({:subscribe, subscription_data}, state) do
    {:reply, {:text, subscription_data}, state}
  end

  @impl true
  def handle_cast({:get, key, coinpair}, state) do
    value = state[coinpair][key]
    {:reply, value, state}
  end

  @impl true
  def handle_connect(_conn, state) do
    Logger.info("Boom! Connected to Binance")
    {:ok, state}
  end

  @impl true
  def handle_disconnect(%{reason: {:local, close_reason}}, state) do
    Logger.info("Closed locally for the reason: #{inspect(close_reason)}")
    {:ok, state}
  end

  @impl true
  def handle_disconnect(disconnect_map, state) do
    super(disconnect_map, state)
  end
end
