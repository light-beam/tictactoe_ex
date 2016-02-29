defmodule Tictactoe.Game.GameUpdaterTest do
  import Tictactoe.Game.GameUpdater
  import Tictactoe.Mark

  @board      Tictactoe.Board
  @game_state Tictactoe.Game.GameState
  @player_x   Tictactoe.Game.GameUpdaterTest.PlayerXDouble
  @player_o   Tictactoe.Game.GameUpdaterTest.PlayerODouble
  @ui         UIDouble

  use ExUnit.Case

  setup do
    next_game_state = 
      @game_state.new_state([@player_x, @player_o])
      |> update(@ui)
    { :ok, next_game_state: next_game_state }
  end

  test "updates board", %{ next_game_state: next_game_state } do
    assert @board.mark_at(next_game_state.board, 0) == x
  end

  test "swaps players", %{ next_game_state: next_game_state } do
    assert next_game_state.players == [@player_o, @player_x]
  end

  test "updates current mark", %{ next_game_state: next_game_state } do
    assert next_game_state.mark == o
  end

  defmodule PlayerXDouble do
    def pick_position(_, _) do
      0
    end
  end

  defmodule PlayerODouble do
    def pick_position(_, _) do
      1
    end
  end
end
