defmodule Tictactoe.Game.GameConductorTest do
  use ExUnit.Case

  import Tictactoe.Game.GameConductor
  import Tictactoe.Helpers

  @board             Tictactoe.Board
  @game_state        Tictactoe.Game.GameState
  @board_display_ui  Tictactoe.Game.GameConductorTest.BoardDisplayUIDouble
  @result_display_ui Tictactoe.Game.GameConductorTest.ResultDisplayUIDouble
  @clear_display_ui  Tictactoe.Game.GameConductorTest.ClearDisplayUIDouble
  @game_updater      Tictactoe.Doubles.GameUpdaterFake

  test "plays if game is not in final state" do
    initial_game_state = @game_state.new_state(:players)
    
    next_game_state = play(initial_game_state, @game_updater, @board_display_ui)

    assert is_updated(initial_game_state, next_game_state) == true
  end

  test "does not play if game is in final state" do
    next_game_state = play(final_game_state, @game_updater, @board_display_ui)

    assert is_updated(final_game_state, next_game_state) == false
  end

  test "runs until end game state" do
    game_state = @game_state.new_state(:players)
    
    last_game_state = play(game_state, @game_updater, @board_display_ui)

    assert @game_state.final?(last_game_state) == true
  end

  test "displays board" do
    game_state = @game_state.new_state(:players)
    
    play(game_state, @game_updater, @board_display_ui)
    invoked = invocation_details

    assert invoked.name == :display_board
    assert invoked.args == game_state.board
  end

  test "displays result" do
    game_state = @game_state.new_state(:players)

    final_game_state = play(game_state, @game_updater, @result_display_ui)
    invoked = invocation_details

    assert invoked.name == :display_result
    assert invoked.args == @board.winner(final_game_state.board)
  end

  test "clears screen" do
    game_state = @game_state.new_state(:players)

    play(game_state, @game_updater, @clear_display_ui)
    invoked = invocation_details

    assert invoked.name == :clear_screen
    assert invoked.args == []
  end

  defp is_updated(initial_state, next_game_state) do
    initial_state.board != next_game_state.board
  end

  defmodule BoardDisplayUIDouble do
    def display_board(board) do
      echo_invoked(%{name: :display_board, args: board})
    end

    def display_result(_) do end
    def clear_screen do end
  end

  defmodule ResultDisplayUIDouble do
    def display_result(winner) do
      echo_invoked(%{name: :display_result, args: winner})
    end

    def display_board(_) do end
    def clear_screen do end
  end

  defmodule ClearDisplayUIDouble do
    def clear_screen do
      echo_invoked(%{name: :clear_screen, args: []})
    end

    def display_result(_) do end
    def display_board(_) do end
  end
end
