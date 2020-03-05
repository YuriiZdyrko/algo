defmodule Mnemonics do
  @moduledoc """
  Given a:
  - ordered list of keys [key1, key2, ...]
  - mappinng of %{
    key1 -> [string1, string2, ...], 
    key2 -> [string3, ...]
    ...
  }
  produce all possible strings permutations for given keys


  P.S. This code is trivial...
  In fact I intended to show different module as a non-trivial example:
  https://github.com/banzay/algo/blob/master/lib/markov/markov.ex
  """

  @doc """
  Convenience method to avoid entering arguments manually in command line
  """
  def generate_combinations() do
    numbers = [2, 3, 4]

    mapping = %{
      2 => ["A", "B", "C"],
      3 => ["D", "E", "F"],
      4 => ["G", "H"],
      5 => ["J", "K", "L"]
    }

    generate_combinations(numbers, mapping)
  end

  @doc ~S"""
  Returns correct result

  ## Examples

      iex> Mnemonics.generate_combinations([2,3,4], %{
      ...>   1 => ["a", "b", "c"],
      ...>   2 => ["d", "e", "f"],
      ...>   3 => ["j"],
      ...>   4 => ["g", "h"]
      ...> })
      ["djg", "djh", "ejg", "ejh", "fjg", "fjh"]

  """
  def generate_combinations(numbers, mapping) do
    mapping
    |> Map.take(numbers)
    |> Map.values()
    |> v2_recursive()
  end

  @doc """
  Approach #1: Iteration
  """
  defp v_iterative(result) do
    1..(length(result) - 1)
    |> Enum.reduce(
      List.first(result),
      fn i, aggr ->
        Enum.flat_map(aggr, fn aggr_item ->
          Enum.map(
            Enum.at(result, i),
            fn new_item -> aggr_item <> new_item end
          )
        end)
      end
    )
  end

  @doc """
  Approach #2: Tail recursion
  """
  defp v_recursive(data) do
    v_recursive(data, length(data), 1, List.first(data))
  end

  defp v_recursive(data, depth, cur_depth, list) when depth == cur_depth do
    list
  end

  defp v_recursive(data, depth, cur_depth, list) do
    res =
      Enum.flat_map(list, fn aggr_item ->
        Enum.map(
          Enum.at(data, cur_depth),
          fn new_item -> aggr_item <> new_item end
        )
      end)

    v_recursive(data, depth, cur_depth + 1, res)
  end

  @doc """
  Approach #3: Recursion
  """
  defp v2_recursive([last]), do: last

  defp v2_recursive([h | t] = data) do
    next = v2_recursive(t)

    for v_h <- h, v_n <- next do
      v_h <> v_n
    end
    |> List.flatten()
  end
end
