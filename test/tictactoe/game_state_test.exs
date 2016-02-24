defmodule Tictactoe.GameStateTest do
  import Tictactoe.GameState
  import Tictactoe.BoardHelpers
  alias  Tictactoe.Board
  alias  Tictactoe.Mark
  alias  Tictactoe.GameStateTest.PlayerXDouble
  alias  Tictactoe.GameStateTest.PlayerODouble

  use ExUnit.Case

  setup do
    { :ok, player_x: PlayerXDouble, player_o: PlayerODouble }
  end

  test "starts with fresh board" do
    board =
      fresh_game_state([])
      |> get_board

    assert Board.fresh?(board) == true
  end

  test "sets players", %{ player_x: player_x, player_o: player_o } do
    players =
      fresh_game_state([player_x, player_o])
      |> get_players

    assert players == [player_x, player_o]
  end

  test "sets primary mark as current" do
    current_mark =
      fresh_game_state([])
      |> get_mark

    assert current_mark == Mark.primary
  end

  test "updates board", %{ player_x: player_x, player_o: player_o } do
    board =
      fresh_game_state([player_x, player_o])
      |> next
      |> get_board

    assert Board.mark_at(board, 0) == Mark.x
  end

  test "swaps players", %{ player_x: player_x, player_o: player_o } do
    players =
      fresh_game_state([player_x, player_o])
      |> next
      |> get_players

    assert players == [player_o, player_x]
  end

  test "updates current mark", %{ player_x: player_x, player_o: player_o } do
    current_mark =
      fresh_game_state([player_x, player_o])
      |> next
      |> get_mark

    assert current_mark == Mark.o
  end

  test "is over" do
    assert over?(end_state) == true
  end

  test "is not over" do
    assert over?(active_state) == false
  end

  defp end_state do
    { win_board, [], nil }
  end

  defp active_state do
    { board_with_one_move, [], nil }
  end

  defp get_board(game_state) do
    { board, _, _ } = game_state
    board
  end

  defp get_players(game_state) do
    { _, players, _ } = game_state
    players
  end

  def get_mark(game_state) do
    { _, _, mark } = game_state
    mark
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
