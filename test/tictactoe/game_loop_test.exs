defmodule Tictactoe.GameLoopTest do
  import Tictactoe.GameLoop
  import Tictactoe.Helpers
  import Integer
  alias  Tictactoe.GameState
  alias  Tictactoe.GameLoopTest.GameUpdaterDouble

  use ExUnit.Case

  test "updates non final game state" do
    initial_game_state = GameState.new_state(:players)
    
    next_game_state = run(initial_game_state, GameUpdaterDouble)

    assert is_updated(initial_game_state, next_game_state) == true
  end

  test "does not update final game state" do
    next_game_state = run(final_game_state, GameUpdaterDouble)

    assert is_updated(final_game_state, next_game_state) == false
  end

  test "runs until end game state" do
    game_state = GameState.new_state([HumanPlayer, HumanPlayer])
    
    last_game_state = run(game_state, GameUpdaterDouble)

    assert GameState.final?(last_game_state) == true
  end

  defp is_updated(initial_state, next_game_state) do
    initial_state.board != next_game_state.board
  end

  defmodule GameUpdaterDouble do
    import Tictactoe.Mark
    alias  Tictactoe.Board

    def update(game_state) do
      %GameState{ board: next_board(game_state.board) }
    end

    defp next_board(board) do
      Board.add_move(board, get_position(board), current_mark(board))
    end

    defp get_position(board) do
      Enum.random(Board.vacant_positions(board))
    end

    defp current_mark(board) do
      count_x_marks(board)
      |> mark_from_count
    end

    defp count_x_marks(board) do
      Map.values(board)
        |> Enum.count(fn(mark) -> mark == x end)
    end

    defp mark_from_count(count) do
      is_odd(count) && o || x
    end
  end
end
