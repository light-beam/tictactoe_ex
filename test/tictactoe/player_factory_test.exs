defmodule Tictactoe.PlayerFactoryTest do
  use ExUnit.Case

  import Tictactoe.PlayerFactory

  @human  Tictactoe.HumanPlayer
  @ai     Tictactoe.AIPlayer

  test "makes correct players" do
    assert make(:hvh) == [@human, @human]
    assert make(:hvc) == [@human, @ai]
    assert make(:cvh) == [@ai, @human]
    assert make(:cvc) == [@ai, @ai]
  end
end
