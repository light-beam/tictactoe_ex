defmodule Tictactoe.GameState do
  alias Tictactoe.Board
  alias Tictactoe.Mark
  alias __MODULE__

  defstruct [ :board, :players, :mark ]

  def new_state(players) do
    make_state(Board.new_board, players, Mark.primary)
  end

  def over?(game_state) do
    Board.inactive?(game_state.board)
  end

  def make_state(board, players, mark) do
    %GameState{ board:   board,
                players: players,
                mark:    mark }
  end

end
