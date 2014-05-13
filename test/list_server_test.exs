defmodule ListServerTest do
  use ExUnit.Case

  setup do
    ListServer.clear
  end

  test "it starts out empty" do
    ListServer.start_link
    assert ListServer.items == []
  end
end
