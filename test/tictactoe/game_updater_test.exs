defmodule Tictactoe.GameUpdaterTest do
  import Tictactoe.GameUpdater
  import Tictactoe.Mark
  alias  Tictactoe.GameState
  alias  Tictactoe.Board
  alias  Tictactoe.GameUpdaterTest.PlayerXDouble
  alias  Tictactoe.GameUpdaterTest.PlayerODouble

  use ExUnit.Case

  setup do
    next_game_state = 
      GameState.new_state([PlayerXDouble, PlayerODouble])
      |> update
    { :ok, next_game_state: next_game_state }
  end

  test "updates board", %{ next_game_state: next_game_state } do
    assert Board.mark_at(next_game_state.board, 0) == x
  end

  test "swaps players", %{ next_game_state: next_game_state } do
    assert next_game_state.players == [PlayerODouble, PlayerXDouble]
  end

  test "updates current mark", %{ next_game_state: next_game_state } do
    assert next_game_state.mark == o
  end

  defmodule PlayerXDouble do
    def pick_position(_) do
      0
    end
  end

  defmodule PlayerODouble do
    def pick_position(_) do
      1
    end
  end
end
