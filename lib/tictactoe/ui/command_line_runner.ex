defmodule Tictactoe.UI.CommandLineRunner do

  @player_factory Tictactoe.PlayerFactory

  @continue "yes"

  def start(game, game_state, ui) do
    ui.clear_screen
    ui.greet
    ui.get_game_option
    |> @player_factory.make
    |> game_state.new_state
    |> game.play(ui)

    if replay?(ui) do
      start(game, game_state, ui)
    else
      ui.astelavista
    end
  end

  defp replay?(ui) do
    ui.get_replay_option == @continue
  end
end
