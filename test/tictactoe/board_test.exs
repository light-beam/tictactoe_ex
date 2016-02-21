defmodule Tictactoe.BoardTest do
  import Tictactoe.Board
  import Enum, only: [count: 1]
  use ExUnit.Case

  test "has default size" do
    assert count(new_board) == 9
  end

  test "new board is empty" do
    assert empty?(new_board)
  end
end
