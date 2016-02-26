defmodule Tictactoe.CLITest do
  import Tictactoe.CLI

  use ExUnit.Case

  test "shows message" do
    io = setup_io("")

    show(io, "message")

    assert output_content(io) == "message"
  end

  test "retrieves input" do
    io = setup_io("input")

    assert get_input(io) == "input"
  end

  defp setup_io(input) do
    {_, io} = StringIO.open(input, capture_prompt: true)
    io
  end

  defp output_content(io) do
    { _, out } = StringIO.contents(io)
    out
  end
end
