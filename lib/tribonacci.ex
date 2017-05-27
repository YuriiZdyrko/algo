defmodule TribonacciSequence do

  @spec tribonacci({number, number, number}, non_neg_integer) :: [number]
  def tribonacci(signature, n) do
    calc(Tuple.to_list(signature), n, Tuple.to_list(signature), 3)
  end

  def calc(signature, n, result, step) when length(signature) >= n do
    Enum.slice(signature, 0..n-1)
  end

  def calc(_, n, result, step) when step == n do
    result
  end

  def calc(signature, n, result, step) do
    calc(signature, n, result ++ [Enum.sum(
      Enum.slice(result, length(result) - 3, length(result))
    )], step + 1)
  end


end
