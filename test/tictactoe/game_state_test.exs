defmodule Tictactoe.GameStateTest do
  import Tictactoe.GameState
  import Tictactoe.Helpers
  alias  Tictactoe.Board
  alias  Tictactoe.Mark

  use ExUnit.Case

  test "starts with fresh board" do
    assert Board.fresh?(new_state(:players).board) == true
  end

  test "sets players" do
    given_players = [PlayerX, PlayerO]

    players = new_state(given_players).players

    assert players == given_players
  end

  test "sets primary mark as current" do
    assert new_state(:players).mark == Mark.primary
  end

  test "is final" do
    assert final?(final_game_state) == true
  end

  test "is not final" do
    assert final?(active_game_state) == false
  end
end
