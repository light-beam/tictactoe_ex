defmodule Tictactoe.Mark do

  def x do
    "X"
  end

  def o do
    "O"
  end

  def void do
    "-"
  end

  def primary do
    x
  end

  def player_marks do
    [x, o]
  end
  
  def opponent(mark) do
    ternary(mark)
  end

  def empty?(mark) do
    mark == void
  end

  defp ternary(mark) do
    mark == x && o || x
  end
end
