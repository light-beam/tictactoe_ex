defmodule Tictactoe.BoardTest do
  import Tictactoe.Board
  import Tictactoe.Mark
  import Tictactoe.BoardHelpers

  use ExUnit.Case

  test "new board is empty" do
    assert fresh?(new_board) == true
  end

  test "returns mark for a given position" do
    assert mark_at(new_board, 0) == void
  end

  test "adds move" do
    board = add_move(new_board, 1, x)
    assert mark_at(board, 1) == x
  end

  test "returns vacant positions" do
    assert vacant_positions(win_board) == [5, 6, 7, 8]
  end

  test "is full" do
    assert full?(drawn_board) == true
  end

  test "is not full" do
    assert full?(board_with_one_move) == false
  end

  test "returns winner if present" do
    assert winner(win_board) == x
  end

  test "no winner if drawn" do
    assert winner(drawn_board) == nil
  end

  test "no winner when active" do
    assert winner(board_with_one_move) == nil
  end

  test "is active" do
    assert inactive?(board_with_one_move) == false
  end

  test "inactive if winner present" do
    assert inactive?(win_board) == true
  end

  test "inactive when drawn" do
    assert inactive?(drawn_board) == true
  end

  test "position is vacant" do
    assert vacant_position?(new_board, 0) == true
  end

  test "position is not vacant" do
    assert vacant_position?(board_with_one_move, 0) == false
  end
end
