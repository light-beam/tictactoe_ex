defmodule Tictactoe.HumanPlayer do

  def pick_position(board, ui) do
    board |> ui.get_position
  end
end
