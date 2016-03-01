defmodule Tictactoe.UI.CommandLineIO do

  @line_space "\n"

  def show(message) do
    IO.puts(message <> @line_space)
  end

  def request_input(request) do
    IO.gets(request)
  end

  def clear_screen do
    IO.write(IO.ANSI.clear)
    IO.write(IO.ANSI.home)
  end
end
