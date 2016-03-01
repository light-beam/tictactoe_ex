defmodule Tictactoe.PlayerFactory do

  @human Tictactoe.HumanPlayer

  @options %{ hvh: [@human, @human] }

  def make(option) do
    @options[option]
  end
end
