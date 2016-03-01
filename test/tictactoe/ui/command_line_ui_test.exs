defmodule Tictactoe.UI.CommandLineUITest do
  use ExUnit.Case

  import Tictactoe.UI.CommandLineUI
  import Tictactoe.UI.BoardFormatter
  import Tictactoe.Helpers
  import Tictactoe.Board
  import Tictactoe.Mark
  import ExUnit.CaptureIO

  @greeting             "Welcome to the Tic Tac Toe Arcade!\n\n" <>
                        "1 - play with a friend\n"              <>
                        "2 - play first against AI\n"           <>
                        "3 - play second against AI\n"          <>
                        "4 - computer plays against itself"

  @replay_prompt        "1 - yes\n" <>
                        "2 - no\n"    <>
                        "One more game? "

  @position_prompt      "Please select position: "
  @invalid_option_alert "This option does not exist, try again"
  @non_numeric_alert    "Invalid input, number required"
  @draw_result          "It's a draw!"
  @farewell             "Astelavista..."
  @game_option_prompt   "Please enter game option number: "

  test "greets" do
    output = capture_io(fn -> greet end)

    assert contains?(output, @greeting)
  end

  test "gets game option" do
    output = capture_io("1", fn ->
      assert get_game_option == :hvh
    end)

    assert output == @game_option_prompt
  end

  test "alerts and keeps requesting till valid game option" do
    output = capture_io("a\n5\n1", fn ->
      assert get_game_option == :hvh
    end)

    assert contains?(output, @non_numeric_alert)
    assert contains?(output, @invalid_option_alert)
  end

  test "gets position" do
    output = capture_io("1", fn ->
      assert get_position(new_board) == 0
    end)

    assert contains?(output, @position_prompt)
  end

  test "alerts and keeps requesting till valid position" do
    output = capture_io("invalid\n10\n1\n2", fn ->
      assert get_position(first_position_taken_board) == 1
    end)

    assert contains?(output, @non_numeric_alert)
    assert contains?(output, @invalid_option_alert)
    assert ends_with?(output, @position_prompt)
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

    assert contains?(output, @draw_result)
  end

  test "clears screen" do
    output = capture_io(fn ->
      clear_screen
    end)

    assert contains?(output, "\e[2J\e[H")
  end

  test "gets translated replay option" do
    output = capture_io("2", fn ->
      assert get_replay_option == "no"
    end)

    assert contains?(output, @replay_prompt)
  end

  test "alerts and keeps requesting till valid replay option" do
    output = capture_io("a\n5\n2", fn ->
      assert get_replay_option == "no"
    end)

    assert contains?(output, @non_numeric_alert)
    assert contains?(output, @invalid_option_alert)
  end

  test "bids farewell" do
    output = capture_io(fn ->
      astelavista
    end)

    assert contains?(output, @farewell)
  end
end
