defmodule Tictactoe.HumanPlayerTest do
  import Tictactoe.HumanPlayer
  import Tictactoe.Helpers

  @ui    Tictactoe.HumanPlayerTest.UIDouble
  @board Tictactoe.Board

  use ExUnit.Case

  test "picks position" do
    board = @board.new_board

    pick_position(board, @ui)

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
