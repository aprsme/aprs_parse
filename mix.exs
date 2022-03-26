defmodule AprsParse.MixProject do
  use Mix.Project

  def project do
    [
      app: :aprs_parse,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      name: "aprs_parse",
      source_url: "https://github.com/aprsme/aprs_parse",
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev},
      {:certifi, "~> 2.9"},
      {:credo, "~> 1.4 ", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.14", only: :test}
    ]
  end

  defp description() do
    "Parse APRS messages into meaningful data structures"
  end

  defp package() do
    [
      name: "aprs_parse",
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/aprsme/aprs_parse"}
    ]
  end
end
