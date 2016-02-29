defmodule Tictactoe.GameTest do
  use ExUnit.Case

  import Tictactoe.Helpers
  import ExUnit.CaptureIO
  
  @ui             Tictactoe.UI.CommandLineUI
  @player_x       Tictactoe.HumanPlayer
  @player_o       Tictactoe.HumanPlayer
  @game_state     Tictactoe.Game.GameState
  @game_updater   Tictactoe.Game.GameUpdater
  @game_conductor Tictactoe.Game.GameConductor

  test "plays out game till the end" do
    game_state = @game_state.new_state([@player_x, @player_o])

    capture_io("1\n4\n2\n5\n3", fn ->
      final_game_state = @game_conductor.play(game_state, @game_updater, @ui)
      assert final_game_state.board == win_board
    end)
  end

end
