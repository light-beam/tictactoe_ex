defmodule Tictactoe.UI.BoardFormatterTest do

  import Tictactoe.UI.BoardFormatter
  import Tictactoe.Board
  import Tictactoe.Helpers

  use ExUnit.Case

  test "formats empty board" do
    assert format(new_board) == " 1 | 2 | 3 \n" <>
                                "-----------\n" <> 
                                " 4 | 5 | 6 \n" <>
                                "-----------\n" <>
                                " 7 | 8 | 9 " 
  end

  test "formats full board" do
    assert format(drawn_board) == " X | O | X \n" <>
                                  "-----------\n" <> 
                                  " X | O | X \n" <>
                                  "-----------\n" <>
                                  " O | X | O " 
  end

  test "formats partially full board" do
    assert format(win_board) == " X | X | X \n" <>
                                "-----------\n" <> 
                                " O | O | 6 \n" <>
                                "-----------\n" <>
                                " 7 | 8 | 9 " 
  end
end
