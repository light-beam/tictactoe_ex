defmodule Tictactoe.GameState do
  alias __MODULE__

  @board Tictactoe.Board
  @mark  Tictactoe.Mark

  defstruct [ :board, :players, :mark ]

  def new_state(players) do
    make_state(@board.new_board, players, @mark.primary)
  end

  def final?(game_state) do
    @board.final?(game_state.board)
  end

  def make_state(board, players, mark) do
    %GameState{ board:   board,
                players: players,
                mark:    mark }
  end
end
