defmodule Tictactoe.GameUpdater do
  @game_state Tictactoe.GameState
  @board Tictactoe.Board
  @mark Tictactoe.Mark

  def update(game_state, ui) do
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
    |> next_player(game_state.players).pick_position(ui)
  end

  defp next_player(players) do
    List.first(players)
  end

  defp swap_players(game_state) do
    Enum.reverse(game_state.players)
  end

  defp next_mark(game_state) do
    @mark.opponent(game_state.mark)
  end
end
