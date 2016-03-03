defmodule Tictactoe.AIPlayer do

  @ai    Tictactoe.Minimax
  @board Tictactoe.Board

  def pick_position(board, _) do
    board
    |> @ai.best_position(@board.current_mark(board))
  end
end
