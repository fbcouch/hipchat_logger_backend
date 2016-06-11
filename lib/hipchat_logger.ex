defmodule HipchatLogger do
  require Logger

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
      <strong>#{message}</strong><br>
      <i>Level</i>: #{level}<br>
      <i>Application</i>: #{application}<br>
      <i>Module</i>: #{module}<br>
      <i>Function</i>: #{function}<br>
      <i>File</i>: #{file}<br>
      <i>Line</i>: #{line}<br>
    """ |> send_event(level)
  end

  defp handle_event(level, message, [pid: _, module: module, function: function, file: file, line: line]) do
    """
      <strong>#{message}</strong><br>
      <i>Level</i>: #{level}<br>
      <i>Module</i>: #{module}<br>
      <i>Function</i>: #{function}<br>
      <i>File</i>: #{file}<br>
      <i>Line</i>: #{line}<br>
    """ |> send_event(level)
  end

  defp handle_event(level, message, details) do
    """
      <strong>#{message}</strong><br>
      <i>Level</i>: #{level}<br>
    """ |> send_event(level)
  end

  defp handle_event(_, _, _) do
    :noop
  end

  defp send_event(html, level) do
    {:ok, body} = Poison.encode %{
      from: @opts[:from],
      message_format: "html",
      message: html,
      color: color(level)
    }
    HTTPoison.post(endpoint, body, headers)
  end

  defp endpoint do
    "https://api.hipchat.com/v2/room/#{@opts[:room]}/notification"
  end

  defp headers do
    %{
      "Authorization" => "Bearer #{@opts[:token]}",
      "Content-Type" => "application/json"
    }
  end

  defp color(:error),
    do: "red"

  defp color(:warn),
    do: "yellow"

  defp color(_),
    do: "gray"
end
