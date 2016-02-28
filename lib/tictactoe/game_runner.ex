defmodule Tictactoe.GameRunner do
  alias Tictactoe.GameState

  def run(game_state, game_updater, ui) do
    display_board(game_state, ui)

    cond do
      GameState.final?(game_state) -> game_state
      true -> game_updater.update(game_state)
              |> run(game_updater, ui)
    end
  end

  defp display_board(game_state, ui) do
    game_state.board
    |> ui.display_board
  end
end
