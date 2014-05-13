defmodule ListServer do
  use GenServer.Behaviour

  ### Public API

  def start_link do
    :gen_server.start_link {:local, :my_list_server}, __MODULE__, [], []
  end

  def clear do
    :gen_server.cast :my_list_server, :clear
  end

  def add(item) do
    :gen_server.cast :my_list_server, {:add_item, item}
  end

  def remove(item) do
    :gen_server.cast :my_list_server, {:remove_item, item}
  end

  def crash_it! do
    :gen_server.cast :my_list_server, :provoke_crash
  end

  def items do
    :gen_server.call :my_list_server, :items
  end

  ### GenServer API

  def init(list) do
    {:ok, list}
  end

  def handle_cast(:clear, _list) do
    {:noreply, []}
  end

  def handle_cast({:add_item, item}, list) do
    {:noreply, list ++ [item]}
  end

  def handle_cast({:remove_item, item}, list) do
    {:noreply, List.delete(list, item)}
  end

  def handle_cast(:provoke_crash, _list) do
    1 = 2
  end

  def handle_call(:items, _from, list) do
    {:reply, list, list}
  end
end
