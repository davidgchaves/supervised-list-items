defmodule ListServer do
  use GenServer.Behaviour

  ### Public API

  def start_link do
    :gen_server.start_link {:local, :my_list_server}, __MODULE__, [], []
  end

  def clear do
    :gen_server.cast :my_list_server, :clear
  end

  def items do
    :gen_server.call :my_list_server, :items
  end

  ### GenServer API

  def init(list) do
    {:ok, list}
  end

  def handle_cast(:clear, list) do
    {:noreply, []}
  end

  def handle_call(:items, _from, list) do
    {:reply, list, list}
  end
end
