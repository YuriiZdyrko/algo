defmodule Snail do

  @doc """

  Converts a matrix to a list by walking around its edges from the top-left going clockwise.

  ![snail walk](http://www.haan.lu/files/2513/8347/2456/snail.png)

  iex> Snail.snail( [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ] )
  [ 1, 2, 3, 6, 9, 8, 7, 4, 5 ]

  """

  @spec snail( [ [ term ] ] ) :: [ term ]

  def snail(matrix), do: snail(matrix, [])
  def snail([], result), do: result
  def snail([last], result), do: result ++ last
  def snail([h | t], result) do
    {mid, [bottom]} = Enum.split(t, -1)
    {left, right, rest} = process_middle_rows(mid)
    snail(rest, result ++ h ++ right ++ Enum.reverse(bottom) ++ left)
  end

  def process_middle_rows(rows) do
    right = Enum.map(rows, fn(i) -> List.last(i) end)
    left = Enum.reverse(Enum.map(rows, fn(i) -> List.first(i) end))
    rest = Enum.map(rows, fn(i) ->
      Enum.slice(i, 1, length(i) - 2)
    end)
    {left, right, rest}
  end
end
