defmodule Tictactoe.Board do
  import Tictactoe.Mark
  import Integer, only: [is_odd: 1]

  @dimension 3
  @default_size @dimension*@dimension
  @winning_combinations [[0, 1, 2],
                         [3, 4, 5],
                         [6, 7, 8],
                         [0, 3, 6],
                         [1, 4, 7],
                         [2, 5, 8],
                         [0, 4, 8],
                         [2, 4, 6]]

  def new_board do
    (0..@default_size - 1)
    |> Enum.reduce(Map.new,
                   fn(position, acc) -> Map.put(acc, position, void) end)
  end

  def mark_at(board, position) do
    board |> Map.fetch!(position)
  end

  def add_move(board, position, mark) do
    board |> Map.put(position, mark)
  end
    
  def fresh?(board) do
    board |> marks_not_present?(player_marks)
  end

  def full?(board) do
    board |> marks_not_present?([void])
  end

  def vacant_positions(board) do
    board
    |> Stream.filter(fn({_, mark}) -> empty?(mark) end)
    |> Enum.into(Map.new)
    |> get_positions
  end

  def winner(board) do
    line = winner_line(board)
    line && hd(line)
  end

  def final?(board) do
    !!winner(board) || full?(board)
  end

  def current_mark(board) do
    board
    |> count_marks
    |> mark_from_count
  end

  defp count_marks(board) do
    Map.values(board)
    |> Enum.count(fn(mark) -> mark != void end)
  end

  defp mark_from_count(count) do
    is_odd(count) && o || x
  end

  def vacant_position?(board, position) do
    board |> mark_at(position) |> empty?
  end

  def rows(board) do
    board |> Enum.chunk(@dimension)
  end

  def get_positions(board) do
    board |> Map.keys
  end

  defp winner_line(board) do
    board
    |> lines_for
    |> Enum.find(fn(line) -> full_single_mark_line?(line) end)
  end

  defp full_single_mark_line?(line) do
    [ h | t ] = Enum.uniq(line)
    Enum.empty?(t) && Enum.member?(player_marks, h)
  end

  defp lines_for(board) do
    @winning_combinations
    |> Stream.map(fn(combination) ->
      marks_for(board, combination)
    end)
  end

  defp marks_for(board, positions) do
    positions
    |> Stream.map(fn(position) -> mark_at(board, position) end)
    |> Enum.into([])
  end

  defp marks_not_present?(board, marks) do
    !(board |> Enum.any?(fn({_, mark}) ->
      Enum.member?(marks, mark)
    end))
  end
end
