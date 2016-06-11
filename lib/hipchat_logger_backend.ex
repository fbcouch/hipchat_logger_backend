defmodule HipchatLoggerBackend do

  @moduledoc """
  A logger backend for posting errors to Hipchat.

  ## Usage

  First, add the client to your `mix.exs` dependencies:

  ```elixir
  def deps do
  [{:hipchat_logger_backend, "~> 0.0.1"}]
  end
  ```

  Then run `$ mix do deps.get, compile` to download and compile your dependencies.

  Finally, add the `:hipchat_logger_backend` application as your list of applications in `mix.exs`:

  ```elixir
  def application do
  [applications: [:logger, :hipchat_logger_backend]]
  end
  ```

  You can set the log levels you want posted to hipchat in the config:

  ```elixir
  config :hipchat_logger_backend, :levels, [:debug, :info, :warn, :error]
  ```
  """

  use Application
  require Logger

  @doc false
  def start(_, _) do
    Logger.add_backend(HipchatLogger)
    {:ok, self}
  end

  @doc false
  def stop(_) do
    :ok
  end

end
