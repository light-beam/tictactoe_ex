defmodule Tictactoe.CommandLineIO do

  def show(message) do
    IO.write(message)
  end

  def request_input(request) do
    IO.gets(request)
  end
end
