defmodule Tictactoe.HumanPlayerTest do
  import Tictactoe.HumanPlayer
  import Tictactoe.Helpers
  alias  Tictactoe.Board
  alias  Tictactoe.HumanPlayerTest.UIDouble

  use ExUnit.Case

  test "picks position" do
    board = Board.new_board

    pick_position(board, UIDouble)

    invoked = invocation_details
    assert invoked.name == :get_position
    assert invoked.args == board
  end

  defmodule UIDouble do
    def get_position(board) do
      echo_invoked(%{name: :get_position, args: board})
    end
  end
end
