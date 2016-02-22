defmodule Tictactoe.BoardTest do
  import Tictactoe.Board
  alias Enum
  alias IO
  use ExUnit.Case

  test "has default size" do
    assert size(new_board) == default_size
  end

  test "is empty" do
    assert empty?(new_board)
  end

  test "is full" do
    assert full?(drawn_board)
  end

  test "adds move" do
    board = add_move(new_board, 1, :x)
    assert mark_at(board, 1) == :x
  end

  defp drawn_board do
    make_board([:x, :o, :x,
                :x, :o, :x,
                :o, :x, :o])
  end

  defp make_board(marks) do
    marks
    |> Enum.with_index
    |> Enum.reduce(new_board,
                   fn({ mark, position }, acc) ->
                     add_move(acc, position, mark)
                   end)
  end
end
