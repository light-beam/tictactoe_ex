defmodule Tictactoe.UI.ReplaySelector do

  @numeric_fetcher Tictactoe.UI.NumericFetcher
  @option_validator Tictactoe.UI.OptionValidator

  @replay_prompt  "One more game?"
  @replay_options %{ 1 => "yes",
                     2 => "no" }

  def select do
    prompt_for_replay
    |> @numeric_fetcher.get_number
    |> validate_replay_option
  end

  defp prompt_for_replay do
    @replay_prompt <> "\n" <> readable_replay_options
  end

  defp readable_replay_options do
    @replay_options
    |> Enum.map(fn({ option, description }) ->
                  to_string(option) <> " - " <> description
                end)
    |> Enum.join("\n")
  end

  defp validate_replay_option(option) do
    cond do
      Map.has_key?(@replay_options, option) -> translate_option(option)
      true -> @option_validator.alert
              select
    end
  end

  defp translate_option(option) do
    Map.get(@replay_options, option)
  end
end
