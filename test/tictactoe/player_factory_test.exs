defmodule Tictactoe.PlayerFactoryTest do
  use ExUnit.Case

  import Tictactoe.PlayerFactory

  @human  Tictactoe.HumanPlayer

  test "makes correct players" do
    assert make(:hvh) == [@human, @human]
  end
end
