defmodule Tictactoe.HumanPlayer do

  def pick_position(board, ui) do
    ui.get_position(board)
  end
end
