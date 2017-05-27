defmodule Snail2 do

  @doc """

  Converts a matrix to a list by walking around its edges from the top-left going clockwise.

  ![snail walk](http://www.haan.lu/files/2513/8347/2456/snail.png)

  iex> Snail.snail( [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ] )
  [ 1, 2, 3, 6, 9, 8, 7, 4, 5 ]

  """

  def run do
    array = [[1,2,3],
         [8,9,4],
         [7,6,5]]
    snail(array)
  end

  @spec snail( [ [ term ] ] ) :: [ term ]

  def snail( matrix ), do: snail(matrix, [])

  def snail([top_row | matrix], acc) do
    snail(rotate_left(matrix), Enum.reverse(top_row) ++ acc)
  end

  def snail(_, acc), do: acc |> Enum.reverse

  def rotate_left(matrix) do
    IO.inspect(matrix)
    res = matrix
      |> List.zip
      |> Enum.reverse
      |> Enum.map(&Tuple.to_list/1)
    IO.inspect res
  end
end
