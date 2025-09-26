defmodule ReviewdogCredo.Mixfile do
  use Mix.Project

  def project do
    [
      app: :reviewdog_credo,
      version: "0.0.1",
      elixir: "~> 1.18",
      deps: deps()
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false}
    ]
  end
end
