defmodule Tictactoe.HumanPlayerTest do
  import Tictactoe.HumanPlayer
  alias Tictactoe.Board
  import Tictactoe.Mark
  alias Tictactoe.HumanPlayerTest.UIDouble, as: UIDouble
  alias Tictactoe.UI
  alias IO
  use ExUnit.Case
  import Mock

  test "picks position" do
    board = Board.new_board
    with_mock UIDouble, [get_position: fn(_) -> "irrelevant" end] do
      pick_position(board, UIDouble)
      assert called UIDouble.get_position(board)
    end
  end

  defmodule UIDouble do
    def get_position(board) do
    end
  end
end
