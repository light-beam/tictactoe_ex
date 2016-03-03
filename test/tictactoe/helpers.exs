defmodule Tictactoe.Helpers do

  import Tictactoe.Board
  import Tictactoe.Mark
  alias  Tictactoe.GameState

  def drawn_board do
    make_board([x, o, x,
                x, o, x,
                o, x, o])
  end

  def win_board do
    make_board([x,    x,    x,
                o,    o,    void,
                void, void, void])
  end

  def first_position_taken_board do
    make_board([x,    void, void,
                void, void, void,
                void, void, void])
  end

  def make_board(marks) do
    marks
    |> Stream.with_index
    |> Enum.reduce(new_board,
                   fn({ mark, position }, acc) ->
                     add_move(acc, position, mark)
                   end)
  end

  def final_game_state(players) do
    %GameState{ board: win_board, players: players }
  end

  def active_game_state do
    %GameState{ board: first_position_taken_board }
  end

  def invocation_details do
    receive do
      details -> details
    after
      0 -> %{ name: :no_name, args: [] }
    end
  end

  def echo_invoked(details) do
    send(self, details)
  end

  def contains?(body, segment) do
    String.contains?(body, segment)
  end

  def ends_with?(body, segment) do
    String.ends_with?(body, segment)
  end
end
