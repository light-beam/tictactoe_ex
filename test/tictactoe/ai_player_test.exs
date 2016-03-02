defmodule Tictactoe.AIPlayerTest do
  use ExUnit.Case

  import Tictactoe.AIPlayer
  import Tictactoe.Mark
  import Tictactoe.Helpers

  test "takes a win" do
    board = make_board([void, void, void,
                        void, o,    x,
                        void, o,    x])

    assert pick_position(board, :ui) == 2
  end

  test "takes a win as second player" do
    board = make_board([x, x, o,
                        o, o, void,
                        x, x, void])

    assert pick_position(board, :ui) == 5
  end
end
