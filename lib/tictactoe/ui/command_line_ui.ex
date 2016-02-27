defmodule Tictactoe.UI.CommandLineUI do
  @io              Tictactoe.UI.CommandLineIO
  @board           Tictactoe.Board
  @numeric_fetcher Tictactoe.UI.NumericFetcher

  @prompt_for_position     "Please select position: "
  @invalid_option_alert    "Invalid option, please try again"

  def get_position(board) do
    @numeric_fetcher.get_number(@prompt_for_position)
    |> zero_index_offset
    |> validate_position(board)
  end

  defp zero_index_offset(number) do
    number - 1
  end

  defp validate_position(given, board) do
    valid_options = @board.vacant_positions(board)

    cond do
      valid_option?(valid_options, given) -> given
      true -> alert_invalid_option
              @numeric_fetcher.get_number(@prompt_for_position)
    end
  end

  defp alert_invalid_option do
    @io.show(@invalid_option_alert)
  end

  defp valid_option?(valid_options, option) do
    Enum.member?(valid_options, option)
  end
end
