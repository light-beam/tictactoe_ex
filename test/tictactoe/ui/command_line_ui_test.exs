defmodule Tictactoe.UI.CommandLineUITest do
  use ExUnit.Case

  import Tictactoe.UI.CommandLineUI
  import Tictactoe.UI.BoardFormatter
  import Tictactoe.Helpers
  import Tictactoe.Board
  import Tictactoe.Mark
  import ExUnit.CaptureIO

  @invalid_option_alert "Invalid option, please try again"
  @non_numeric_alert    "Invalid input, number required"

  test "greets" do
    output = capture_io(fn -> greet end)

    assert contains?(output, "Welcome to the Tic Tac Toe Arcade!")
  end

  test "displays game options" do
    output = capture_io("1", fn ->
      get_game_option
    end)

    assert output == "Please enter option number:\n"  <>
                     "1 - play with a friend\n"       <>
                     "2 - play first against AI\n"    <>
                     "3 - play second against AI\n"   <>
                     "4 - computer plays against itself\n"
  end

  test "retrieves game option" do
    capture_io("1", fn ->
      assert get_game_option == 1
    end)
  end

  test "alerts and keeps requesting till valid game option" do
    output = capture_io("a\n5\n1", fn ->
      get_game_option == 1
    end)

    assert contains?(output, @non_numeric_alert)
    assert contains?(output, @invalid_option_alert)
  end

  test "prompts for position input" do
    output = capture_io("1", fn ->
      get_position(new_board)
    end)

    assert contains?(output, "Please select position:")
  end

  test "translates position input into position" do
    capture_io("1", fn ->
      assert get_position(new_board) == 0
    end)
  end

  test "alerts if position is taken" do
    output = capture_io("1\n2", fn ->
      get_position(first_position_taken_board)
    end)

    assert contains?(output, @invalid_option_alert)
  end

  test "alerts and keeps requesting till valid position" do
    output = capture_io("invalid\n10\n1", fn ->
      assert get_position(new_board) == 0
    end)

    assert contains?(output, @non_numeric_alert)
    assert contains?(output, @invalid_option_alert)
    assert ends_with?(output, "Please select position:\n")
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

  test "bids farewell" do
    output = capture_io(fn ->
      astelavista
    end)

    assert contains?(output, "Astelavista...")
  end
end
