defmodule Krypto.MixProject do
  use Mix.Project

  def project do
    [
      app: :krypto,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      releases: releases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Krypto.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:websockex, "~> 0.4.3"},
      {:jason, "~> 1.4"}
    ]
  end

  # Releasing versions
  defp releases do
    [
      krypto: [
        include_executables_for: [:unix],
        applications: [runtime_tools: :permanent],
        path: "./releases"
      ]
    ]
  end
end
