defmodule Twitter.Mixfile do
  use Mix.Project

  def project do
    [app: :twitter,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :extwitter,:gen_stage],
    mod: {Twitter.Application, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:poison, "~> 2.0"},
      {:hackney, "~> 1.7.0", override: true},
      {:httpoison, "~> 1.1.0"},
      {:oauth, github: "tim/erlang-oauth"},
      {:extwitter, "~> 0.7.2"},
      {:gen_stage, "~> 0.5"},
      {:sentient, "~> 0.0.2", git: "https://github.com/rdalin82/sentient.git"},
      {:gibran, git: "https://github.com/abitdodgy/gibran.git"},
      {:stemmer, git: "https://github.com/fredwu/stemmer.git"}
    ]
  end
end
