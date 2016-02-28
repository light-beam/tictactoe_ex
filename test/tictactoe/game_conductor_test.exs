defmodule Tictactoe.GameConductorTest do
  import Tictactoe.GameConductor
  import Tictactoe.Helpers
  import Integer

  @game_state   Tictactoe.GameState
  @player_x     PlayerDouble
  @player_o     PlayerDouble
  @ui           Tictactoe.GameConductorTest.UIDouble
  @game_updater Tictactoe.GameConductorTest.GameUpdaterDouble

  use ExUnit.Case

  test "updates non final game state" do
    initial_game_state = @game_state.new_state(:players)
    
    next_game_state = play(initial_game_state, @game_updater, @ui)

    assert is_updated(initial_game_state, next_game_state) == true
  end

  test "does not update final game state" do
    next_game_state = play(final_game_state, @game_updater, @ui)

    assert is_updated(final_game_state, next_game_state) == false
  end

  test "runs until end game state" do
    game_state = @game_state.new_state([@player_x, @player_o])
    
    last_game_state = play(game_state, @game_updater, @ui)

    assert @game_state.final?(last_game_state) == true
  end

  test "displays board" do
    game_state = @game_state.new_state([@player_x, @player_o])
    
    play(game_state, @game_updater, @ui)
    
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

    @board Tictactoe.Board

    def update(game_state, _) do
      %Tictactoe.GameState{ board: next_board(game_state.board) }
    end

    defp next_board(board) do
      @board.add_move(board, get_position(board), current_mark(board))
    end

    defp get_position(board) do
      Enum.random(@board.vacant_positions(board))
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
