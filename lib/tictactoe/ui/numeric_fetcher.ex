defmodule Tictactoe.UI.NumericFetcher do
  @io Tictactoe.UI.CommandLineIO

  @non_numeric_input_alert "Invalid input, number required"

  def get_number(message) do
    @io.request_input(message)
    |> into_numeric
    |> validate_numeric(message)
  end

  defp into_numeric(received_input) do
    result = Integer.parse(received_input)
    cond do
      result == :error -> result
      true -> { value, _ } = result
      value
    end
  end

  defp validate_numeric(input, message) do
    cond do
      input != :error -> input
      true -> alert_non_numeric
      get_number(message)
    end
  end

  defp alert_non_numeric do
    @io.show(@non_numeric_input_alert)
  end
end
