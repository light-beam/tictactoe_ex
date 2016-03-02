defmodule Tictactoe.PlayerFactory do

  @ai    Tictactoe.AIPlayer
  @human Tictactoe.HumanPlayer

  @options %{ hvh: [@human, @human],
              hvc: [@human, @ai],
              cvh: [@ai, @human],
              cvc: [@ai, @ai] }

  def make(option) do
    @options[option]
  end
end
