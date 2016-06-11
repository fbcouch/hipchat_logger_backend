defmodule HipchatLogger do
  require Logger
  alias Romeo.Stanza
  alias Romeo.Connection, as: Conn

  @moduledoc """
  Does the actual work of posting to HipChat.
  """
  @opts Application.get_env(:hipchat_logger_backend, :hipchat)

  use GenEvent

  @doc false
  def init(__MODULE__) do
    {:ok, %{}}
  end

  @doc false
  def handle_call(_request, state) do
    {:ok, state}
  end

  @doc false
  def handle_event({level, _pid, {Logger, message, _timestamp, detail}}, state) do
    levels = case Application.get_env(:hipchat_logger_backend, :levels) do
      nil ->
        [:error] # by default only log error level messages
      levels ->
        levels
    end
    if level in levels do
      handle_event(level, message, detail)
    else
    end
    {:ok, state}
  end

  @doc false
  def handle_info(_message, state) do
    {:ok, state}
  end

  defp handle_event(level, message, [pid: _, application: application, module: module, function: function, file: file, line: line]) do
    """
      An event has occurred: _#{message}_
      *Level*: #{level}
      *Application*: #{application}
      *Module*: #{module}
      *Function*: #{function}
      *File*: #{file}
      *Line*: #{line}
    """ |> send_event
  end

  defp handle_event(level, message, [pid: _, module: module, function: function, file: file, line: line]) do
    """
      An event has occurred: _#{message}_
      *Level*: #{level}
      *Module*: #{module}
      *Function*: #{function}
      *File*: #{file}
      *Line*: #{line}
    """ |> send_event
  end

  defp handle_event(_, _, _) do
    :noop
  end

  def send_event(text) do
    # Start the client
    {:ok, pid} = Conn.start_link(@opts)

    # # Send presence to the server
    # :ok = Conn.send(pid, Stanza.presence)
    #
    # # Request your roster
    # :ok = Conn.send(pid, Stanza.get_roster)
    #
    # # Join a chat room
    # :ok = Conn.send(pid, Stanza.join(@opts[:room], @opts[:nickname]))

    # Send a message to the room
    IO.inspect @opts[:rooms]
    @opts[:rooms]
    |> Enum.each(fn room ->
      :ok = Conn.send(pid, Stanza.join(elem(room, 0), @opts[:nickname]))
      :ok = Conn.send(pid, Stanza.groupchat(room, text))
    end)
  end
end
