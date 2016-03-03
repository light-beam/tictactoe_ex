defmodule Tictactoe.Game do

  @game_state Tictactoe.GameState
  @board      Tictactoe.Board
  @mark       Tictactoe.Mark

  def play(game_state, ui) do
    ui.clear_screen
    game_state |> display_board(ui)
    cond do
      @game_state.final?(game_state) -> display_result(game_state, ui)
                                        game_state
      true -> play_turn(game_state, ui)
              |> play(ui)
    end
  end

  def play_turn(game_state, ui) do
    @game_state.make_state(next_board(game_state, ui),
                           swap_players(game_state),
                           next_mark(game_state))
  end

  defp next_board(game_state, ui) do
    @board.add_move(game_state.board,
                    get_position(game_state, ui),
                    game_state.mark)
  end

  defp get_position(game_state, ui) do
    game_state.board
    |> List.first(game_state.players).pick_position(ui)
  end

  defp swap_players(game_state) do
    Enum.reverse(game_state.players)
  end

  defp next_mark(game_state) do
    @mark.opponent(game_state.mark)
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
end
