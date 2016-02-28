defmodule Tictactoe.GameRunner do
  @game_state Tictactoe.GameState

  def run(game_state, game_updater, ui) do
    display_board(game_state, ui)

    cond do
      @game_state.final?(game_state) -> game_state
      true -> game_updater.update(game_state, ui)
              |> run(game_updater, ui)
    end
  end

  defp display_board(game_state, ui) do
    game_state.board
    |> ui.display_board
  end
end
