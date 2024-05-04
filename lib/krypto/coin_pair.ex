defmodule Krypto.CoinPair do
  @moduledoc """
  A GenServer module for managing the state of a crypto coinpairs.

  ## Responsibilities
    - Maintain and update the state of a specific cryptocurrency coin pair prices.
    - Api function to get the average price of the coinpair
    - Asynchronously subscribes the given coinpair
    - Asynchronously tracks the prices of the coinpair
  """
  use GenServer
  @me __MODULE__

  # Starts the GenServer and regsiters with module name
  def start_link(_opts) do
    GenServer.start_link(@me, %{}, name: @me)
  end

  # -----------#
  # Client API #
  # -----------#
  @doc """
  Asynchronously Process the sock message
  """
  def process(message) do
    GenServer.cast(@me, {:process, message})
  end

  @spec get_average(String.t()) :: {:ok, float()}
  def get_average(pair) do
    pair = String.downcase(pair)
    GenServer.call(@me, {:get_average, pair})
  end

  @spec subscribe(String.t()) :: :ok
  def subscribe(pair) do
    pair = String.downcase(pair)
    GenServer.cast(@me, {:subscribe, pair})
  end

  # GenServer callbacks
  @impl true
  def init(initial_state) do
    {:ok, initial_state}
  end

  @impl true
  def handle_cast({:process, message}, state) do
    ticker_stream = Krypto.to_ticker_stream(message)
    {:noreply, update_average_prices(state, ticker_stream)}
  end

  @impl true
  def handle_cast({:subscribe, coin_pair}, state) do
    Krypto.Binance.subscribe(coin_pair)
    {:noreply, state}
  end

  @impl true
  def handle_call({:get_average, pair}, _from, state) do
    average_price = calculate_average(state, pair)
    {:reply, average_price, state}
  end

  # Private Helper functions to manage state
  defp update_average_prices(state, %{"symbol" => pair, "last_price" => price}) do
    pair = String.downcase(pair)
    price = String.to_float(price)
    prices = Map.get(state, pair, [])
    new_prices = [price | prices]
    Map.put(state, pair, new_prices)
  end

  defp calculate_average(state, pair) do
    prices = Map.get(state, pair, [])
    if prices == [], do: {:error, :not_found}, else: {:ok, Enum.sum(prices) / length(prices)}
  end
end
