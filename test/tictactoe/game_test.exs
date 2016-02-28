defmodule Tictactoe.GameTest do
  alias  Tictactoe.GameRunner
  alias  Tictactoe.GameState
  alias  Tictactoe.HumanPlayer
  alias  Tictactoe.GameUpdater
  alias  Tictactoe.UI.CommandLineUI
  import Tictactoe.Helpers
  import ExUnit.CaptureIO

  use ExUnit.Case

  test "plays out game till the end" do
    game_state = GameState.new_state([HumanPlayer, HumanPlayer])

    capture_io("1\n4\n2\n5\n3", fn ->
      final_game_state = GameRunner.run(game_state, GameUpdater, CommandLineUI)
      assert final_game_state.board == win_board
    end)
  end

end
