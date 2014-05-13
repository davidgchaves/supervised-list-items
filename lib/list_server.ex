defmodule ListServer do
  use GenServer.Behaviour

  ### Public API

  def start_link(list_data_pid) do
    :gen_server.start_link {:local, :my_list_server}, __MODULE__, list_data_pid, []
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

  def init(list_data_pid) do
    {:ok, {ListData.get_state(list_data_pid), list_data_pid}}
  end

  def handle_cast(:clear, {_list, list_data_pid}) do
    {:noreply, {[], list_data_pid}}
  end

  def handle_cast({:add_item, item}, {list, list_data_pid}) do
    {:noreply, {list ++ [item], list_data_pid}}
  end

  def handle_cast({:remove_item, item}, {list, list_data_pid}) do
    {:noreply, {List.delete(list, item), list_data_pid}}
  end

  def handle_cast(:provoke_crash, _state) do
    1 = 2
  end

  def handle_call(:items, _from, {list, list_data_pid}) do
    {:reply, list, {list, list_data_pid}}
  end

  def terminate(_reason, {list, list_data_pid}) do
    ListData.save_state list_data_pid, list
  end
end
