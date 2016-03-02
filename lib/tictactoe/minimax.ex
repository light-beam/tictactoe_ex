defmodule Tictactoe.Minimax do

  @mark Tictactoe.Mark
  @board Tictactoe.Board

  @win_score   10
  @draw_score  0
  @loss_score -10

  def best_position(board, own_mark) do
    max_scored_position(board, own_mark)
    |> extract_position
  end

  defp max_scored_position(board, own_mark) do
    board
    |> @board.vacant_positions
    |> Enum.reduce(%{},
                   fn(position, acc) -> Map.put(acc, position, score(@board.add_move(board, position, own_mark), @mark.opponent(own_mark), own_mark)) end)
    |> Enum.max_by(fn({ _, score }) -> score end)
  end

  def score(board, current_mark, own_mark) do
    if @board.final?(board) do
      final_score(board, own_mark)
    else
      board
      |> @board.vacant_positions
      |> Stream.map(fn(position) -> @board.add_move(board, position, current_mark) end)
      |> Stream.map(fn(board) -> score(board, @mark.opponent(current_mark), own_mark) end)
      |> filter_scores(current_mark, own_mark)
    end
  end

  defp extract_position(scored_position) do
    { position, _ } = scored_position
    position
  end

  defp filter_scores(scores, current_mark, own_mark) do
    if current_mark == own_mark do
      scores |> Enum.max
    else
      scores |> Enum.min
    end
  end


  defp final_score(board, mark) do
    winner = @board.winner(board)

    cond do
      win?(winner, mark)  -> @win_score
      loss?(winner, mark)  -> @loss_score
      true                   -> @draw_score
    end
  end

  defp win?(winner, mark) do
    mark == winner
  end

  defp loss?(winner, mark) do
    @mark.opponent(mark) == winner
  end
end
