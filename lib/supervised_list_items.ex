defmodule SupervisedListItems do
  use Application

  # See http://elixir-lang.org/docs/stable/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    SupervisedListItems.Supervisor.start_link
  end
end
