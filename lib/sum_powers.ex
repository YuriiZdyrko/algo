defmodule Challenge do

  def run do
    solution(5)
  end

  @divisors [3, 5]


  def solution(number) when number <= 3, do: 0
  def solution(number) do
    number
    |> collect(@divisors)
    |> filter_divisible_by_both
    |> Enum.sum

    # number
  end

  def collect(number, divisors) do
    divisors
    |> Enum.flat_map(fn(divisor) ->
      0..round(Float.floor((number - 1) / divisor))
      |> Enum.map(&(&1 * divisor))
    end)
  end

  def filter_divisible_by_both(arr) do
    arr
    |> Enum.sort
    |> Enum.dedup
  end
end
