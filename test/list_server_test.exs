defmodule ListServerTest do
  use ExUnit.Case

  setup do
    ListServer.clear
  end

  test "it starts out empty" do
    ListServer.start_link
    assert ListServer.items == []
  end

  test "it adds items to the list" do
    ListServer.start_link

    ListServer.add "a book"
    assert ListServer.items == ["a book"]
  end

  test "it removes items from the list" do
    ListServer.start_link
    ListServer.add "a book!"
    ListServer.add "a movie!"

    ListServer.remove "a book!"
    assert ListServer.items == ["a movie!"]
  end
end
