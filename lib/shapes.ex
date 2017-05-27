defmodule Shapes do

  @moduledoc """
  Finds matching shapes (horizontal and vertical lines of length 3)
  in 2-dimensinal array.
  """

  @shapes [
    [0,1,1,1,1,1,1,1,1,1,1],
    [0,0,0,1,1,1,1,1,1,1,1],
    [0,0,0,1,1,1,1,1,1,1,1],
    [1,1,0,1,1,1,1,1,1,1,1],
    [1,1,1,1,1,1,1,1,1,1,1],
    [1,1,1,1,0,0,0,0,1,1,1],
    [1,1,1,1,1,1,1,1,1,1,1],
    [1,1,1,1,0,0,0,1,1,1,1],
    [1,1,1,1,1,1,1,1,1,1,1],
    [1,0,0,0,1,1,1,1,1,1,1],
    [1,1,1,1,1,1,1,1,1,1,1]
  ]

  def run do
    find(@shapes)
  end

  @doc """
  Process each row
  """
  def find(shapes) do
    shapes
    |> Enum.with_index
    |> Enum.flat_map(fn({_, index}) ->
      process_row(shapes, index)
    end)

    |> List.flatten
    |> Enum.filter(&(&1 !== nil))

    |> Enum.sort
    |> Enum.dedup
  end

  @doc """
  Run explore/4 for each found "0" in a row
  """
  defp process_row(shapes, row_index) do
    shapes
    |> Enum.at(row_index)
    |> Enum.with_index
    |> Enum.map(fn({cell, cell_index}) ->
      if cell === 0 do
        res = explore(shapes, {row_index, cell_index}, {row_index, cell_index}, MapSet.new([{row_index, cell_index}]))
        process_cube(res)
      end
    end)
  end

  @doc """
  Accepts initial coordinates, uses them to
  recursively check adjacent cells for "0" values.
  Returns MapSet of results
  """
  defp explore(shapes, coords, curr_coords, result) do
    # Recursion will be terminated when no adjacent "0" cells are discovered
    # in all 4 directions

    # Check 4 directions for adjacent "0" cells
    all_new_found = check_all_dirs(shapes, coords, curr_coords)

    new_found = MapSet.difference(all_new_found, result)
    new_result = MapSet.union(result, all_new_found)

    MapSet.union(
      new_result,
      Enum.reduce(new_found, new_result, fn(new_found_coord, acc) ->
        explore(shapes, coords, new_found_coord, acc)
      end)
    )
  end

  @doc """
  Accepts array of {x, y} coordinates of every "0" in_range
  Returns array of matching shapes or empty array
  """
  defp process_cube(cube) do
    cube_arr = Enum.into(cube, [])

    x_row = cube_arr
    |> Enum.sort_by(fn({_, x}) -> x end)
    |> Enum.chunk_by(fn({_, x}) -> x end)

    y_row = cube_arr
    |> Enum.sort_by(fn({y, _}) -> y end)
    |> Enum.chunk_by(fn({y, _}) -> y end)

    [x_row, y_row]
    |> Enum.flat_map(fn(axis_results) ->
      axis_results
      |> Enum.filter(fn(i) -> length(i) == 3 end)
      |> Enum.map(fn(i) -> Enum.into(i, MapSet.new()) end)
    end)
  end

  defp in_range?({y, x}, {y2, x2}) do
    pos(y2 - y) < 3 && pos(x2 - x) < 3
  end

  defp pos(num) when num < 0, do: -num
  defp pos(num), do: num

  defp check_all_dirs(shapes, coords, curr_coords) do
    [:right, :down, :left, :up]
    |> Enum.map(fn(i) -> check_dir(shapes, curr_coords, i) end)
    |> Enum.filter(fn({_, v}) -> v !== 1 end)
    |> Enum.map(fn({found_coords, _}) -> found_coords end)
    |> Enum.filter(fn(found_coords) -> in_range?(coords, found_coords) end)
    |> Enum.into(MapSet.new)
  end

  @doc """
  Returns array of "0" siblings for single cell
  """
  defp check_dir(shapes, {y, x}, dir) do
    {y, x} = case dir do
      :right -> {y, x + 1}
      :down -> {y - 1, x}
      :left -> {y, x - 1}
      :up -> {y + 1, x}
    end

    if (y < 0 || x < 0 || y >= length(shapes) || x >= length(shapes)) do
      {{y, x}, 1}
    else
      v = shapes
      |> Enum.at(y)
      |> Enum.at(x)
      {{y, x}, v}
    end
  end
end
