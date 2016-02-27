defmodule Tictactoe.UITest do
  import Tictactoe.UI
  import Tictactoe.Helpers
  import ExUnit.CaptureIO
  alias  Tictactoe.Board
  alias  Tictactoe.CommandLineIO
  alias  Tictactoe.UITest.IOSpy

  use ExUnit.Case

  test "prompts for position input" do
    get_position(IOSpy, Board.new_board)

    invoked = invocation_details

    assert invoked.name == :request_input
    assert invoked.args == "Please select position: "
  end

  test "translates position input into position" do
    assert get_position(IOSpy, Board.new_board) == 0
  end

  test "alerts when non-numeric input" do
    output = capture_io("invalid\n1", fn ->
      get_position(CommandLineIO, Board.new_board)
    end)

    assert contains?(output, "Invalid input, number required")
  end

  test "keeps requesting till numeric input" do
    output = capture_io("invalid\n1", fn ->
      assert get_position(CommandLineIO, Board.new_board) == 0
    end)

    assert ends_with?(output, "Please select position: ")
  end

  test "alerts if numeric input is not a valid position" do
    output = capture_io("1\n2", fn ->
      get_position(CommandLineIO, first_position_taken_board)
    end)

    assert contains?(output, "Invalid option, please try again")
  end

  test "keeps requesting till valid position" do
    output = capture_io("invalid\n1", fn ->
      assert get_position(CommandLineIO, Board.new_board) == 0
    end)

    assert ends_with?(output, "Please select position: ")
  end

  defmodule IOSpy do
    import Tictactoe.Helpers

    def request_input(message) do
      echo_invoked(%{ name: :request_input, args: message})
      "1"
    end
  end
end
