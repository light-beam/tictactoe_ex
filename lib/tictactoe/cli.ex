defmodule Tictactoe.CLI do

  def show(io, message) do
    IO.write(io, message)
  end

  def get_input(io) do
    IO.read(io, :line)
  end
end
