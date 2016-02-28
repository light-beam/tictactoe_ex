defmodule Tictactoe.GameTest do
  import Tictactoe.Helpers
  import ExUnit.CaptureIO
  
  @player_x     Tictactoe.HumanPlayer
  @player_o     Tictactoe.HumanPlayer
  @game_state   Tictactoe.GameState
  @game_conductor Tictactoe.GameConductor
  @game_updater Tictactoe.GameUpdater
  @ui           Tictactoe.UI.CommandLineUI

  use ExUnit.Case

  test "plays out game till the end" do
    game_state = @game_state.new_state([@player_x, @player_o])

    capture_io("1\n4\n2\n5\n3", fn ->
      final_game_state = @game_conductor.play(game_state, @game_updater, @ui)
      assert final_game_state.board == win_board
    end)
  end

end
