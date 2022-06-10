defmodule UtrustChallenge.MixProject do
  use Mix.Project

  def project do
    [
      app: :utrust_challenge,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:ethereumex],
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ethereumex, "~> 0.9"},
      {:ex_abi, "~> 0.5"}
    ]
  end
end
