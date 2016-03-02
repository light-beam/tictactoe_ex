defmodule Tictactoe.MinimaxTest do
  use ExUnit.Case

  import Tictactoe.Minimax
  import Tictactoe.Mark
  import Tictactoe.Helpers
  
  test "takes a win as first player" do
    board = make_board([void, void, void,
                        void, o,    x,
                        void, o,    x])

    assert best_position(board, x) == 2
  end

  test "blocks as X" do
    board = make_board([void, void, void,
                        void, o,    void,
                        o,    x,    x])

    assert best_position(board, x) == 2
  end

  test "takes a win as second player" do
    board = make_board([x, x, o,
                        o, o, void,
                        x, x, void])

    assert best_position(board, o) == 5
  end

  test "blocks as O" do
    board = make_board([void, void, void,
                        void, o,    void,
                        x,    void, x    ])

    assert best_position(board, o) == 7
  end

  test "scores winning board" do
    assert score(win_board, x, x) == 10
  end

  test "scores drawn board" do
    assert score(drawn_board, x, x) == 0
  end

  test "scores losing board" do
    assert score(x_loss_board, x, x) == -10
  end

  test "scores near win" do
    assert score(x_near_win_board, x, x) == 10
  end

  test "scores near draw" do
    assert score(near_draw_board, x, x) == 0
  end

  test "scores near loss when not own turn" do
    assert score(x_near_loss_board, o,  x) == -10
  end

  test "scores future win" do
    assert score(x_future_win_board, x, x) == 10
  end

  test "scores future loss" do
    assert score(x_future_loss_board, o, x) == -10
  end

  test "scores future draw" do
    assert score(future_draw_board, x, x) == 0
  end

  defp x_near_win_board do
    make_board([x,    o,    void,
                x,    o,    void,
                void, void, void])
  end

  defp x_near_loss_board do
    make_board([x,    x,    void,
                o,    o,    void,
                void, void, x    ])
  end

  def x_future_win_board do
    make_board([x,    void, void,
                o,    void, void,
                void, void, void ])
  end

  def x_future_loss_board do
    make_board([x,    o,    void,
                x,    o,    x,
                void, void, void ])
  end

  defp future_draw_board do
    make_board([x,    void, void,
                void, o,    void,
                void, void, void])
  end

  defp near_draw_board do
    make_board([x, o, void,
                o, o, x,
                x, x, o])
  end

  def x_loss_board do
    make_board([x,  void, o,
                x,  o,    x,
                o,  x,    void])
  end
end
