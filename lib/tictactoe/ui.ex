defmodule Tictactoe.UI do
  alias Tictactoe.Board

  @prompt_for_position     "Please select position: "
  @non_numeric_input_alert "Invalid input, number required"
  @invalid_option_alert    "Invalid option, please try again"

  def get_position(io, board) do
    get_number(io, @prompt_for_position)
    |> zero_index_offset
    |> validate_position(board, io)
  end

  defp get_number(io, message) do
    io.request_input(message)
    |> into_number
    |> validate_numeric(io, message)
  end

  defp zero_index_offset(number) do
    number - 1
  end

  defp into_number(received_input) do
    result = Integer.parse(received_input)
    cond do
      result == :error -> result
      true -> { value, _ } = result
                value
    end
  end

  defp validate_numeric(input, io, message) do
    cond do
      input != :error -> input
      true -> alert_invalid_input(io)
              get_number(io, message)
    end
  end

  defp alert_invalid_input(io) do
    io.show(@non_numeric_input_alert)
  end

  defp alert_invalid_option(io) do
    io.show(@invalid_option_alert)
  end

  defp validate_position(given, board, io) do
    valid_options = Board.vacant_positions(board)

    cond do
      valid_option?(valid_options, given) -> given
      true -> alert_invalid_option(io)
              get_number(io, @prompt_for_position)
    end
  end

  defp valid_option?(valid_options, option) do
    Enum.member?(valid_options, option)
  end
end
