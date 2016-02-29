defmodule Tictactoe.UI.CommandLineUI do
  @io                Tictactoe.UI.CommandLineIO
  @game_selector     Tictactoe.UI.GameSelector
  @board_formatter   Tictactoe.UI.BoardFormatter
  @position_selector Tictactoe.UI.PositionSelector

  @greeting             "Welcome to the Tic Tac Toe Arcade!"

  def greet do
    @greeting |> @io.show
  end

  def get_game_option do
    @game_selector.select
  end

  def display_board(board) do
    board
    |> @board_formatter.format
    |> @io.show
  end

  def get_position(board) do
    @position_selector.select(board)
  end

  def display_result(mark) do
    cond do
      mark -> display_winner(mark)
      true -> display_draw
    end
  end

  def clear_screen do
    @io.clear_screen
  end

  defp display_winner(winner) do
    "Player " <> to_string(winner) <> " has won this game!"
    |> @io.show
  end

  defp display_draw do
    "It's a draw!" |> @io.show
  end
end
