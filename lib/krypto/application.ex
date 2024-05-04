defmodule Krypto.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Krypto.Binance,
      Krypto.CoinPair
    ]

    opts = [strategy: :one_for_one, name: Krypto.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
