defmodule ListSupervisor do
  use Supervisor.Behaviour

  ## If you want the Supervisor to do its magic, remember to start with
  ## ListSupervisor.start_link
  ## instead of
  ## ListServer.star_link
  def start_link do
    :supervisor.start_link __MODULE__, []
  end

  def init(list) do
    child_processes = [worker(ListServer, list)]
    supervise child_processes, strategy: :one_for_one
  end
end
