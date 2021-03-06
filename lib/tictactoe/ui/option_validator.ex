defmodule Tictactoe.UI.OptionValidator do

  @io Tictactoe.UI.CommandLineIO

  @invalid_option_alert "This option does not exist, try again"

  def alert do
    @invalid_option_alert |> @io.show
  end

  def valid?(valid_options, option) do
    Enum.member?(valid_options, option)
  end
end
