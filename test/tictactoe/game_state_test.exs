defmodule Tictactoe.GameStateTest do
  import Tictactoe.GameState
  import Tictactoe.BoardHelpers
  alias  Tictactoe.Board
  alias  Tictactoe.Mark

  use ExUnit.Case

  test "starts with fresh board" do
    assert Board.fresh?(new_state(:irrelevant).board) == true
  end

  test "sets players" do
    given_players = [PlayerX, PlayerO]

    players = new_state(given_players).players

    assert players == given_players
  end

  test "sets primary mark as current" do
    assert new_state(:irrelevant).mark == Mark.primary
  end

  test "is final" do
    assert final?(final_state) == true
  end

  test "is not final" do
    assert final?(active_state) == false
  end

  defp final_state do
    make_state( win_board, :irrelevant, :irrelevant )
  end

  defp active_state do
    make_state( board_with_one_move, :irrelevant, :irrelevant )
  end
end
