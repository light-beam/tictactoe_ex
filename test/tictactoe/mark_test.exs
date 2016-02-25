defmodule Tictactoe.MarkTest do
  import Tictactoe.Mark

  use ExUnit.Case

  test "returns player marks" do
    assert player_marks == [x, o]
  end

  test "opponent of O is X" do
    assert opponent(x) == o
  end

  test "opponent of X is O" do
    assert opponent(o) == x
  end

  test "is empty" do
    assert empty?(void) == true
  end

  test "returns primary mark" do
    assert primary == x
  end
end
