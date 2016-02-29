defmodule Tictactoe.UI.GameSelector do
  @numeric_fetcher  Tictactoe.UI.NumericFetcher
  @option_validator Tictactoe.UI.OptionValidator
  
  @prompt_for_option    "Please enter option number:"
  @game_options         %{ 1 => { :hvh, "play with a friend" },
                           2 => { :hvc, "play first against AI" },
                           3 => { :cvh, "play second against AI" },
                           4 => { :cvc, "computer plays against itself" }}

  def select do
    prompt_for_option
    |> @numeric_fetcher.get_number
    |> validate_game_option
  end

  defp validate_game_option(option) do
    cond do
      Map.has_key?(@game_options, option) -> option
      true -> @option_validator.alert
              select
    end
  end

  defp prompt_for_option do
    @prompt_for_option <> "\n" <> readable_game_options
  end

  defp readable_game_options do
    @game_options
    |> Enum.map(fn({ option, { _, description }}) ->
                  to_string(option) <> " - " <> description
                end)
    |> Enum.join("\n")
  end
end
