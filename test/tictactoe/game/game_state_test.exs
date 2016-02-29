defmodule Tictactoe.Game.GameStateTest do
  use ExUnit.Case

  import Tictactoe.Game.GameState
  import Tictactoe.Helpers

  @player_x PlayerXDouble
  @player_o PlayerODouble
  @board    Tictactoe.Board
  @mark     Tictactoe.Mark

  test "starts with fresh board" do
    assert @board.fresh?(new_state(:players).board) == true
  end

  test "sets players" do
    given_players = [@player_x, @player_o]

    players = new_state(given_players).players

    assert players == given_players
  end

  test "sets primary mark as current" do
    assert new_state(:players).mark == @mark.primary
  end

  test "is final" do
    assert final?(final_game_state) == true
  end

  test "is not final" do
    assert final?(active_game_state) == false
  end
end
