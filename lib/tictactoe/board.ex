defmodule Tictactoe.Board do
  import Enum, only: [map: 2, dedup: 1, count: 1, reduce: 3]
  alias Map

  @dimension 3

  def new_board do
    reduce((0..default_size - 1), %{}, fn(position, acc) -> Map.put(acc, position, :none) end)
  end
    
  def empty?(board) do
    not_present?(board, [:x, :o])
  end

  def full?(board) do
    not_present?(board, [:none])
  end

  def add_move(board, position, mark) do
    Map.put(board, position, mark)
  end

  def mark_at(board, position) do
    Map.fetch!(board, position)
  end

  def size(board) do
    Enum.count(board)
  end

  def default_size do
    @dimension*@dimension
  end

  defp not_present?(board, marks) do
    !Enum.any?(board, fn(move) -> Enum.member?(marks, get_mark(move)) end)
  end

  defp get_mark(move) do
    elem(move, 1)
  end
end
