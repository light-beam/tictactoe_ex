defmodule Tictactoe.Doubles.GameUpdaterFake do
  import Integer
  import Tictactoe.Mark
  alias  Tictactoe.Game.GameState

  @board Tictactoe.Board

  def update(game_state, _) do
    %GameState{ board: next_board(game_state.board) }
  end

  defp next_board(board) do
    board
    |> @board.add_move(get_position(board), current_mark(board))
  end

  defp get_position(board) do
    Enum.random(@board.vacant_positions(board))
  end

  defp current_mark(board) do
    board
    |> count_x_marks
    |> mark_from_count
  end

  defp count_x_marks(board) do
    Map.values(board)
    |> Enum.count(fn(mark) -> mark == x end)
  end

  defp mark_from_count(count) do
    is_odd(count) && o || x
  end
end
