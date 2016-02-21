defmodule Tictactoe.Board do
  import Enum, only: [map: 2, dedup: 1]

  @dimension 3

  def new_board do
    map((1..size), fn(_) -> :none end)
  end
    
  def empty?(board) do
    dedup(board) == [:none]
  end

  defp size do
    @dimension*@dimension
  end
end
