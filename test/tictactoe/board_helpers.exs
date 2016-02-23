defmodule Tictactoe.BoardHelpers do
  import Tictactoe.Board

  def drawn_board do
    make_board([:x, :o, :x,
                :x, :o, :x,
                :o, :x, :o])
  end

  def win_board do
    make_board([:x,    :x,    :x,
                :o,    :o,    :none,
                :none, :none, :none])
  end

  def board_with_one_mark do
    make_board([:x,    :none, :none,
                :none, :none, :none,
                :none, :none, :none])
  end

  def make_board(marks) do
    marks
    |> Stream.with_index
    |> Enum.reduce(new_board,
                   fn({ mark, position }, acc) ->
                     add_move(acc, position, mark)
                   end)
  end
end
