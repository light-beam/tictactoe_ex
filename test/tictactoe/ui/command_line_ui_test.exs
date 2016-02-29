defmodule Tictactoe.UI.CommandLineUITest do
  import Tictactoe.UI.CommandLineUI
  import Tictactoe.UI.BoardFormatter
  import Tictactoe.Helpers
  import Tictactoe.Board
  import Tictactoe.Mark
  import ExUnit.CaptureIO

  use ExUnit.Case

  test "prompts for position input" do
    output = capture_io("1", fn ->
      get_position(new_board)
    end)

    assert contains?(output, "Please select position: ")
  end

  test "translates position input into position" do
    capture_io("1", fn ->
      assert get_position(new_board) == 0
    end)
  end

  test "alerts when non-numeric input" do
    output = capture_io("invalid\n1", fn ->
      get_position(new_board)
    end)

    assert contains?(output, "Invalid input, number required")
  end

  test "keeps requesting till numeric input" do
    output = capture_io("invalid\n1", fn ->
      assert get_position(new_board) == 0
    end)

    assert ends_with?(output, "Please select position: ")
  end

  test "alerts if numeric input is not a valid position" do
    output = capture_io("1\n2", fn ->
      get_position(first_position_taken_board)
    end)

    assert contains?(output, "Invalid option, please try again")
  end

  test "keeps requesting till valid position" do
    output = capture_io("invalid\n1", fn ->
      assert get_position(new_board) == 0
    end)

    assert ends_with?(output, "Please select position: ")
  end

  test "displays formatted board" do
    raw_board = win_board
    formatted_board = format(raw_board)

    output = capture_io(fn ->
      display_board(raw_board)
    end)

    assert contains?(output, formatted_board)
  end

  test "displays winning result" do
    output = capture_io(fn ->
      display_result(x)
    end)

    assert contains?(output, "Player X has won this game!")
  end

  test "displays draw result" do
    output = capture_io(fn ->
      display_result(nil)
    end)

    assert contains?(output, "It's a draw!")
  end

  test "clears screen" do
    output = capture_io(fn ->
      clear_screen
    end)

    assert contains?(output, "\e[2J\e[H")
  end
end
