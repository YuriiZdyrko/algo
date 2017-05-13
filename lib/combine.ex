defmodule Combine do

  def run do
    arr = [1,2,3,4,5,6]
    # combine(arr)
  end

  # A, B stable, last - variying
  def combine([h|t], size, result) do
    # combine(Enum.map(t, fn(i) -> h ++ [i] end))
  end
  def combine([], size, result) do
    result
  end

  # when last reaches end - B unstable

  # A stable, pre-last, last - variying

  # Then pre-last reaches end - A unstable

  # None stable, all varying



end
