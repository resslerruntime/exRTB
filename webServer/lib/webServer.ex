defmodule WebServer do
  use Application

  # See http://elixir-lang.org/docs/stable/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    Agent.start_link(fn -> HashDict.new end, name: :inFlight)
    WebServer.Supervisor.start_link
  end
end
