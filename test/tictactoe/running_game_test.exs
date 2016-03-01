defmodule Tictactoe.RunningGameTest do
  use ExUnit.Case

  import Tictactoe.Helpers
  import ExUnit.CaptureIO

  @ui             Tictactoe.UI.CommandLineUI
  @game           Tictactoe.Game
  @player_x       Tictactoe.HumanPlayer
  @player_o       Tictactoe.HumanPlayer
  @game_state     Tictactoe.GameState
  @runner         Tictactoe.UI.CommandLineRunner

  test "sets up game and plays it out game till the end" do
    output = capture_io("1\n1\n4\n2\n5\n3\n2", fn ->
      @runner.start(@game, @game_state, @ui)
    end)

    assert contains?(output, "Welcome to the Tic Tac Toe Arcade!")
    assert contains?(output, "Please enter game option number:")
    assert contains?(output, "Player X has won this game")
    assert contains?(output, "One more game?")
    assert contains?(output, "Astelavista...")
  end
end
