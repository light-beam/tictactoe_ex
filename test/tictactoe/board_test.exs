defmodule Tictactoe.BoardTest do
  import Tictactoe.Board
  use ExUnit.Case

  test "new board is empty" do
    assert empty?(new_board) == true
  end

  test "returns mark for a given position" do
    assert mark_at(new_board, 0) == :none
  end

  test "adds move" do
    board = add_move(new_board, 1, :x)
    assert mark_at(board, 1) == :x
  end

  test "returns vacant positions" do
    assert vacant_positions(win_board) == [5, 6, 7, 8]
  end

  test "is full" do
    assert full?(drawn_board) == true
  end

  test "is not full" do
    assert full?(board_with_one_mark) == false
  end

  test "returns winner if present" do
    assert winner(win_board) == :x
  end

  test "no winner if drawn" do
    assert winner(drawn_board) == nil
  end

  test "no winner when active" do
    assert winner(board_with_one_mark) == nil
  end

  test "is active" do
    assert active?(board_with_one_mark) == true
  end

  test "is not active when won" do
    assert active?(win_board) == false
  end

  test "is not active when drawn" do
    assert active?(drawn_board) == false
  end

  test "position is vacant" do
    assert vacant_position?(new_board, 0) == true
  end

  test "position is not vacant" do
    assert vacant_position?(board_with_one_mark, 0) == false
  end

  defp drawn_board do
    make_board([:x, :o, :x,
                :x, :o, :x,
                :o, :x, :o])
  end

  defp win_board do
    make_board([:x,    :x,    :x,
                :o,    :o,    :none,
                :none, :none, :none])
  end

  def board_with_one_mark do
    make_board([:x,    :none, :none,
                :none, :none, :none,
                :none, :none, :none])
  end

  defp make_board(marks) do
    marks
    |> Stream.with_index
    |> Enum.reduce(new_board,
                   fn({ mark, position }, acc) ->
                     add_move(acc, position, mark)
                   end)
  end
end
