defmodule Tictactoe.UI.BoardFormatter do

  import Tictactoe.Mark

  @board Tictactoe.Board

  @cell_separator "|"
  @row_separator "\n-----------\n"

  def format(board) do
    board
    |> prepare_cells
    |> group_into_rows
    |> add_cell_separator
    |> add_row_separator
  end

  defp prepare_cells(board) do
    board
    |> @board.get_positions
    |> Enum.map(fn(position) -> prepare_cell(position, board) end)
  end

  defp group_into_rows(cells) do
    cells
    |> @board.rows
  end

  defp add_cell_separator(rows) do
    rows
    |> Enum.map(fn(row) -> Enum.join(row, @cell_separator) end)
  end

  defp add_row_separator(rows) do
    rows
    |> Enum.join(@row_separator)
  end

  defp prepare_cell(position, board) do
    board
    |> @board.mark_at(position)
    |> readable_cell(position)
    |> padded_cell
  end

  defp readable_cell(mark, position) do
    (mark != void) && mark || convert_position(position)
  end

  defp padded_cell(readable_cell) do
    " " <> readable_cell <> " "
  end

  defp convert_position(position) do
    position |> one_index_offset |> to_string
  end

  defp one_index_offset(position) do
    position + 1
  end
end
