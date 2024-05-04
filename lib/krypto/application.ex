defmodule Krypto.Application do
  @moduledoc false

  use Application

  @binance_url "wss://stream.binance.com:9443/ws/stream"
  @impl true
  def start(_type, _args) do
    children = [
      {Krypto.Binance, @binance_url}
    ]

    opts = [strategy: :one_for_one, name: Krypto.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
