hipchat_logger_backend
====================
[![Build Status](https://secure.travis-ci.org/fbcouch/hipchat_logger_backend.png?branch=master "Build Status")](http://travis-ci.org/fbcouch/hipchat_logger_backend)
[![hex.pm version](https://img.shields.io/hexpm/v/hipchat_logger_backend.svg)](https://hex.pm/packages/hipchat_logger_backend)
[![hex.pm downloads](https://img.shields.io/hexpm/dt/hipchat_logger_backend.svg)](https://hex.pm/packages/hipchat_logger_backend)

A logger backend for posting errors to Hipchat.

You can find the hex package [here](https://hex.pm/packages/hipchat_logger_backend), and the docs [here](http://hexdocs.pm/hipchat_logger_backend).

## Usage

First, add the client to your `mix.exs` dependencies:

```elixir
def deps do
  [{:hipchat_logger_backend, "~> 0.0.1"}]
end
```

Then run `$ mix do deps.get, compile` to download and compile your dependencies.

Configure your hipchat credentials

```elixir
config :hipchat_logger_backend, :hipchat,
  token: "my_api_token",
  room: "my_room",
  from: "Test App"
```

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

## Credits

hipchat_logger_backend was forked from slack_logger_backend under the following license:

The MIT License (MIT)

Copyright (c) 2016 Craig Paterson

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
