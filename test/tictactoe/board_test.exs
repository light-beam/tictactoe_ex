defmodule Tictactoe.BoardTest do
  import Tictactoe.Board
  import Tictactoe.Mark
  import Tictactoe.Helpers

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
    assert full?(first_position_taken_board) == false
  end

  test "returns winner if present" do
    assert winner(win_board) == x
  end

  test "no winner if drawn" do
    assert winner(drawn_board) == nil
  end

  test "no winner when active" do
    assert winner(first_position_taken_board) == nil
  end

  test "is not final" do
    assert final?(first_position_taken_board) == false
  end

  test "is final if winner present" do
    assert final?(win_board) == true
  end

  test "is final when drawn" do
    assert final?(drawn_board) == true
  end

  test "position is vacant" do
    assert vacant_position?(new_board, 0) == true
  end

  test "position is not vacant" do
    assert vacant_position?(first_position_taken_board, 0) == false
  end

  test "returns positions" do
    assert get_positions(new_board) == [0, 1, 2, 3, 4, 5, 6, 7, 8]
  end

  test "splits into rows" do
    assert rows(get_positions(new_board)) == [[0, 1, 2],
                                              [3, 4, 5],
                                              [6, 7, 8]]
  end
end
