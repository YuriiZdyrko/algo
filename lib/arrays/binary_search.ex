defmodule BinarySearch do
  def run do
    arr = [2, 4, 5, 6, 7, 13, 34, 12, 546, 56, 1, 7]
    search(12, Enum.sort(arr))
  end

  def search(search_term, [result]) when result == search_term do
    "Success"
  end

  def search(search_term, [result]) when result !== search_term do
    "Failure"
  end

  def search(search_term, arr) do
    {left, right} = Enum.split(arr, round(length(arr) / 2))

    if List.first(right) <= search_term do
      search(search_term, right)
    else
      search(search_term, left)
    end
  end
end
