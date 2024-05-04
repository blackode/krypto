defmodule Krypto.Binance do
  use WebSockex
  require Logger

  def start_link(url) do
    WebSockex.start_link(url, __MODULE__, %{})
  end

  def handle_connect(_conn, state) do
    Logger.info("Boom! Connected")
    {:ok, state}
  end

  def handle_disconnect(%{reason: {:local, close_reason}}, state) do
    Logger.info("Closed locally for the reason: #{inspect(close_reason)}")
    {:ok, state}
  end

  def handle_disconnect(disconnect_map, state) do
    super(disconnect_map, state)
  end
end
