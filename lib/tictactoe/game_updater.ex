defmodule Tictactoe.GameUpdater do
  alias Tictactoe.GameState
  alias Tictactoe.Board
  alias Tictactoe.Mark

  def update(game_state) do
    GameState.make_state(next_board(game_state),
                         swap_players(game_state),
                         next_mark(game_state))
  end

  defp next_board(game_state) do
    Board.add_move(game_state.board,
                   get_position(game_state),
                   game_state.mark)
  end

  defp get_position(game_state) do
    next_player(game_state.players).pick_position(game_state.board)
  end

  defp next_player(players) do
    List.first(players)
  end

  defp swap_players(game_state) do
    Enum.reverse(game_state.players)
  end

  defp next_mark(game_state) do
    Mark.opponent(game_state.mark)
  end
end
