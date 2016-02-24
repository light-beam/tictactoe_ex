defmodule Tictactoe.HumanPlayerTest do
  import Tictactoe.HumanPlayer
  alias Tictactoe.Board
  alias Tictactoe.HumanPlayerTest.UIDouble, as: UIDouble
  use ExUnit.Case

  test "picks position" do
    board = Board.new_board

    result = pick_position(board, UIDouble)

    assert result.board_sent == board
    assert result.position_received == 0
  end

  defmodule UIDouble do
    def get_position(board) do
      %{position_received: 0, board_sent: board}
    end
  end
end
