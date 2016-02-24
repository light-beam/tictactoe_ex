defmodule Tictactoe.GameState do
  alias Tictactoe.Board
  alias Tictactoe.Mark

  def fresh_game_state(players) do
    { Board.new_board, players, Mark.primary }
  end

  def next(game_state) do
    { board, players, mark } = game_state

    { next_board(board, players, mark),
      swap_players(players),
      next_mark(mark) }
  end

  def over?(game_state) do
    { board, _, _ } = game_state
    Board.inactive?(board)
  end

  defp next_board(board, players, mark) do
    Board.add_move(board,
                   get_position(players, board),
                   mark)
  end

  defp get_position(players, board) do
    next_player(players).pick_position(board)
  end

  defp next_player(players) do
    List.first(players)
  end

  defp swap_players(players) do
    Enum.reverse(players)
  end

  defp next_mark(mark) do
    Mark.opponent(mark)
  end
end
