defmodule SumOfPairs do

  @doc """

  Finds the first pair of ints as judged by the index of the second value.

  iex> sum_pairs( [ 10, 5, 2, 3, 7, 5 ], 10 )

  { 3, 7 }

  """

  def run do
    sum_pairs(
      List.duplicate([1, 2, 3, 4, 1, 0, 122, 234, 543, 12, 5], 1000000) |> List.flatten,
      126
    )
    #  sum_pairs( [ 1, 4, 8, 7, 3, 15 ], 8 )
  end

  def sum_pairs(ints, sum), do: sum_pairs(
    ints,
    MapSet.new([]),
    sum
  )
  def sum_pairs([], _, _), do: nil
  def sum_pairs([h | t], seen, sum) do
    lol = Enum.filter(seen, fn(v) ->
      v + h === sum
    end)
    if (length(lol) > 0) do
      {List.first(lol), h}
    else
      sum_pairs(t, MapSet.put(seen, h), sum)
    end
  end
end
