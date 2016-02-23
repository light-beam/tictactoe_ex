defmodule Tictactoe.BoardHelpers do
  import Tictactoe.Board
  import Tictactoe.Mark

  def drawn_board do
    make_board([x, o, x,
                x, o, x,
                o, x, o])
  end

  def win_board do
    make_board([x,    x,    x,
                o,    o,    void,
                void, void, void])
  end

  def board_with_one_mark do
    make_board([x,    void, void,
                void, void, void,
                void, void, void])
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
