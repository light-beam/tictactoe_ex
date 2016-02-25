defmodule Tictactoe.GameStateTest do
  import Tictactoe.GameState
  import Tictactoe.BoardHelpers
  alias  Tictactoe.Board
  alias  Tictactoe.Mark

  use ExUnit.Case

  test "starts with fresh board" do
    assert Board.fresh?(new_state([]).board) == true
  end

  test "sets players" do
    expected_players = [PlayerX, PlayerO]

    players = new_state(expected_players).players

    assert players == expected_players
  end

  test "sets primary mark as current" do
    assert new_state([]).mark == Mark.primary
  end

  test "is over" do
    assert over?(end_state) == true
  end

  test "is not over" do
    assert over?(active_state) == false
  end

  defp end_state do
    make_state( win_board, :irrelevant, :irrelevant )
  end

  defp active_state do
    make_state( board_with_one_move, :irrelevant, :irrelevant )
  end
end
