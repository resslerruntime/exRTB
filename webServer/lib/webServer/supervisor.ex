defmodule WebServer.Supervisor do
  use Supervisor.Behaviour
  import Process
  import Kernel
  def start_link do
    :supervisor.start_link(__MODULE__, [])
  end
  def init([]) do
    children = [
      supervisor(WebServer.AppSupervisor, [:a12])
      #,worker(WebServer.Worker, [arg1, arg2, arg3])
    ]
    # See http://elixir-lang.org/docs/stable/Supervisor.Behaviour.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
