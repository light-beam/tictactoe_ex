defmodule Tictactoe.UI.CommandLineUI do
  @io              Tictactoe.UI.CommandLineIO
  @board           Tictactoe.Board
  @numeric_fetcher Tictactoe.UI.NumericFetcher
  @board_formatter Tictactoe.UI.BoardFormatter

  @prompt_for_position  "Please select position: "
  @invalid_option_alert "Invalid option, please try again"

  def display_board(board) do
    board
    |> @board_formatter.format
    |> @io.show
  end

  def get_position(board) do
    @prompt_for_position
    |> @numeric_fetcher.get_number
    |> zero_index_offset
    |> validate_position(board)
  end

  defp zero_index_offset(number) do
    number - 1
  end

  defp validate_position(input, board) do
    valid_options = board |> @board.vacant_positions

    cond do
      valid_option?(valid_options, input) -> input
      true -> alert_invalid_option
              @prompt_for_position
              |> @numeric_fetcher.get_number
    end
  end

  defp alert_invalid_option do
    @invalid_option_alert |> @io.show
  end

  defp valid_option?(valid_options, option) do
    Enum.member?(valid_options, option)
  end
end
