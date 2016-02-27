defmodule Tictactoe.UI.CommandLineIOTest do
  import Tictactoe.UI.CommandLineIO
  import ExUnit.CaptureIO

  use ExUnit.Case

  test "shows message" do
    output = capture_io(fn ->
      show("message")
    end)

    assert output == "message"
  end

   test "requests and receives input" do
     input = "input"

     output = capture_io(input, fn ->
       assert request_input("request") == input
     end)
     assert output == ("request")
  end
end
