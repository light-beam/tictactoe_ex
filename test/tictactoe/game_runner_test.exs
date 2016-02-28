defmodule Tictactoe.GameRunnerTest do
  import Tictactoe.GameRunner
  import Tictactoe.Helpers
  import Integer
  alias  Tictactoe.GameState
  alias  Tictactoe.GameRunnerTest.GameUpdaterDouble
  alias  Tictactoe.GameRunnerTest.UIDouble

  use ExUnit.Case

  test "updates non final game state" do
    initial_game_state = GameState.new_state(:players)
    
    next_game_state = run(initial_game_state, GameUpdaterDouble, UIDouble)

    assert is_updated(initial_game_state, next_game_state) == true
  end

  test "does not update final game state" do
    next_game_state = run(final_game_state, GameUpdaterDouble, UIDouble)

    assert is_updated(final_game_state, next_game_state) == false
  end

  test "runs until end game state" do
    game_state = GameState.new_state([HumanPlayer, HumanPlayer])
    
    last_game_state = run(game_state, GameUpdaterDouble, UIDouble)

    assert GameState.final?(last_game_state) == true
  end

  test "displays board" do
    game_state = GameState.new_state([HumanPlayer, HumanPlayer])
    
    run(game_state, GameUpdaterDouble, UIDouble)
    
    invoked = invocation_details
    assert invoked.name == :display_board
    assert invoked.args == game_state.board
  end

  defp is_updated(initial_state, next_game_state) do
    initial_state.board != next_game_state.board
  end

  defmodule UIDouble do
    def display_board(board) do
      echo_invoked(%{name: :display_board, args: board})
    end
  end

  defmodule GameUpdaterDouble do
    import Tictactoe.Mark
    alias  Tictactoe.Board

    def update(game_state, _) do
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
