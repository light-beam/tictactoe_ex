defmodule Tictactoe.Game.GameConductor do
  @game_state Tictactoe.Game.GameState
  @board      Tictactoe.Board

  def play(game_state, game_updater, ui) do
    ui |> clear_screen
    game_state |> display_board(ui)

    cond do
      @game_state.final?(game_state) -> display_result(game_state, ui)
                                        game_state
      true -> game_updater.update(game_state, ui)
              |> play(game_updater, ui)
    end
  end

  defp display_board(game_state, ui) do
    game_state.board
    |> ui.display_board
  end

  defp display_result(game_state, ui) do
    game_state.board
    |> @board.winner
    |> ui.display_result
  end

  defp clear_screen(ui) do
    ui.clear_screen
  end
end
