defmodule SlackLoggerBackend do

  @moduledoc """
  A logger backend for posting errors to Slack.

  ## Usage

  First, add the client to your `mix.exs` dependencies:

  ```elixir
  def deps do
  [{:slack_logger_backend, "~> 0.0.1"}]
  end
  ```

  Then run `$ mix do deps.get, compile` to download and compile your dependencies.

  Finally, add the `:slack_logger_backend` application as your list of applications in `mix.exs`:

  ```elixir
  def application do
  [applications: [:logger, :slack_logger_backend]]
  end
  ```

  You can set the log levels you want posted to slack in the config:

  ```elixir
  config :slack_logger_backend, :levels, [:debug, :info, :warn, :error]
  ```

  You'll need to create a custom incoming webhook URL for your Slack team. You can either configure the webhook
  in your config:

  ```elixir
  config :slack_logger_backend, :slack, [url: "http://example.com"]
  ```

  ... or you can put the webhook URL in the `SLACK_LOGGER_WEBHOOK_URL` environment variable if you prefer. If
  you have both the environment variable will be preferred.
  """

  use Application
  require Logger

  @doc false
  def start(_, _) do
    Logger.add_backend(SlackLogger)
    {:ok, self}
  end

  @doc false
  def stop(_) do
    :ok
  end

end
