defmodule Tictactoe.GameTest do
  use ExUnit.Case

  import Tictactoe.Game
  import Tictactoe.Helpers
  import Tictactoe.Mark

  @board             Tictactoe.Board
  @game_state        Tictactoe.GameState
  @player_x          Tictactoe.Doubles.PlayerXFake
  @player_o          Tictactoe.Doubles.PlayerOFake
  @ui                Tictactoe.Doubles.UIStub
  @board_display_ui  Tictactoe.GameTest.BoardDisplayUISpy
  @result_display_ui Tictactoe.GameTest.ResultDisplayUISpy
  @clear_screen_ui   Tictactoe.Doubles.ClearScreenUISpy

  test "updates board" do
    next_game_state = play_turn(fresh_game_state, @ui)

    assert @board.mark_at(next_game_state.board, 0) == x
  end

  test "swaps players" do
    next_game_state = play_turn(fresh_game_state, @ui)

    assert next_game_state.players == [@player_o, @player_x]
  end

  test "updates current mark" do
    next_game_state = play_turn(fresh_game_state, @ui)

    assert next_game_state |> marks_were_swapped?
  end

  test "does not play if game is in final state" do
    given_game_state = final_game_state([@player_x, @player_o])

    next_game_state = play(given_game_state, @ui)

    assert has_been_updated(given_game_state, next_game_state) == false
  end

  test "runs until end game state" do
    last_game_state = play(fresh_game_state, @ui)

    assert @game_state.final?(last_game_state) == true
  end

  test "displays board" do
    play(fresh_game_state, @board_display_ui)
    invoked = invocation_details

    assert invoked.name == :display_board
    assert invoked.args == fresh_game_state.board
  end

  test "displays result" do
    final_game_state = play(fresh_game_state, @result_display_ui)
    invoked = invocation_details

    assert invoked.name == :display_result
    assert invoked.args == @board.winner(final_game_state.board)
  end

  test "clears screen" do
    play(fresh_game_state, @clear_screen_ui)
    invoked = invocation_details

    assert invoked.name == :clear_screen
    assert invoked.args == []
  end

  defp fresh_game_state do
    @game_state.new_state([@player_x, @player_o])
  end

  defp marks_were_swapped?(game_state) do
    board = game_state.board
    @board.mark_at(board, 0) != @board.mark_at(board, 1)
  end

  defp has_been_updated(initial_state, next_game_state) do
    initial_state.board != next_game_state.board
  end

  defmodule BoardDisplayUISpy do
    def display_board(board) do
      echo_invoked(%{name: :display_board, args: board})
    end

    def display_result(_) do end
    def clear_screen do end
  end

  defmodule ResultDisplayUISpy do
    def display_result(winner) do
      echo_invoked(%{name: :display_result, args: winner})
    end

    def display_board(_) do end
    def clear_screen do end
  end
end
