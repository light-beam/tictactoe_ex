defmodule Tictactoe.Board do
  alias Enum
  alias Map

  @dimension 3
  @default_size @dimension*@dimension
  @empty_mark :none
  @player_marks [:x, :o]
  @winning_combinations [[0, 1, 2],
                         [3, 4, 5],
                         [6, 7, 8],
                         [0, 3, 6],
                         [1, 4, 7],
                         [2, 5, 8],
                         [0, 4, 8],
                         [2, 4, 6]]

  def new_board do
    Enum.reduce((0..@default_size - 1),
                Map.new,
                fn(position, acc) -> Map.put(acc, position, @empty_mark) end)
  end

  def mark_at(board, position) do
    Map.fetch!(board, position)
  end

  def add_move(board, position, mark) do
    Map.put(board, position, mark)
  end
    
  def empty?(board) do
    not_present?(board, @player_marks)
  end

  def full?(board) do
    not_present?(board, [@empty_mark])
  end

  def vacant_positions(board) do
    board
    |> Stream.filter(fn({_, mark}) -> empty_mark?(mark) end)
    |> Enum.into(Map.new)
    |> Map.keys
  end

  def winner(board) do
    if line = winner_line(board) do
      hd(line)
    end
  end

  def active?(board) do
    !winner(board) && !full?(board)
  end

  def vacant_position?(board, position) do
    mark_at(board, position)
    |> empty_mark?
  end

  defp winner_line(board) do
    lines_for(board)
    |> Enum.find(fn(marks) ->
                     [ h | t ] = Enum.uniq(marks)
                     Enum.empty?(t) && Enum.member?(@player_marks, h)
                   end)
  end

  defp lines_for(board) do
    @winning_combinations
    |> Stream.map(fn(combination) ->
                    marks_for(board, combination)
                  end)
  end

  defp marks_for(board, positions) do
    positions
    |> Stream.map(fn(position) -> board[position] end)
    |> Enum.into([])
  end

  defp not_present?(board, marks) do
    !Enum.any?(board, fn({_, mark}) ->
                        Enum.member?(marks, mark)
                      end)
  end

  defp empty_mark?(mark) do
    mark == @empty_mark
  end
end
