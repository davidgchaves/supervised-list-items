defmodule ListSupervisor do
  use Supervisor.Behaviour

  ## If you want the Supervisor to do its magic, remember to start with
  ## ListSupervisor.start_link
  ## instead of
  ## ListServer.star_link
  def start_link do
    result = {:ok, sup} = :supervisor.start_link(__MODULE__, [])
    start_workers sup
    result
  end

  def start_workers(sup) do
    {:ok, list_data} = :supervisor.start_child sup, worker(ListData, [])

    :supervisor.start_child sup, worker(ListSubSupervisor, [list_data])
  end

  def init(_) do
    supervise [], strategy: :one_for_one
  end
end
