defmodule HipchatLoggerBackend.Mixfile do
  use Mix.Project

  def project do
    [
      app: :hipchat_logger_backend,
      description: "A logger backend for posting errors to HipChat.",
      version: "0.1.1",
      elixir: "~> 1.2",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test],
      package: package
    ]
  end

  def application do
    [applications: [:logger, :httpoison],
    mod: {HipchatLoggerBackend, []}]
  end

  defp deps do
    [
      {:httpoison, "~> 0.8"},
      {:poison, "~> 1.3"},
      {:excoveralls, "~> 0.4", only: :test},
      {:ex_doc, "~> 0.11", only: :dev},
      {:markdown, github: "devinus/markdown", only: :dev}
    ]
  end

  def package do
    [
      files: ["lib", "mix.exs", "README*"],
      licenses: ["MIT"],
      maintainers: ["Jami Couch"],
      links: %{"Github" => "https://github.com/fbcouch/hipchat_logger_backend"}
    ]
  end
end
