defmodule Mix.Tasks.Ttt do
  use Mix.Task

  @moduledoc """
  Starts the Tic Tac Toe game (does not require any arguments)

      mix ttt
  """

  def run(_) do
    Tictactoe.UI.CommandLineRunner.start(Tictactoe.Game, Tictactoe.GameState, Tictactoe.UI.CommandLineUI)
  end
end
