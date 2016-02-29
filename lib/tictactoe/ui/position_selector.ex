defmodule Tictactoe.UI.PositionSelector do
  @board            Tictactoe.Board
  @numeric_fetcher  Tictactoe.UI.NumericFetcher
  @option_validator Tictactoe.UI.OptionValidator

  @prompt_for_position  "Please select position:"

  def select(board) do
    @prompt_for_position
    |> @numeric_fetcher.get_number
    |> zero_index_offset
    |> validate(board)
  end

  defp validate(position, board) do
    valid_options = board |> @board.vacant_positions
    cond do
      @option_validator.valid?(valid_options, position) -> position
      true -> @option_validator.alert
              select(board)
    end
  end

  defp zero_index_offset(number) do
    number - 1
  end
end
