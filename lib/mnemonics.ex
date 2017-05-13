defmodule Mnemonics do

  import IEx
  def run(numbers \\ [2, 3, 4]) do
    mapping = %{
      2 => ["A", "B", "C"],
      3 => ["D", "E", "F"],
      4 => ["G", "H"],
      5 => ["J", "K", "L"]
    }

    generate_combinations(numbers, mapping)
  end

  def generate_combinations(numbers, mapping) do
    result = Enum.map(numbers, &(mapping[&1]))
    # v_iterative(result)
    v_recursive(result)
  end

  def v_iterative(result) do
    1..length(result) - 1
    |> Enum.reduce(
      List.first(result),
      fn(i, aggr) ->
        Enum.flat_map(aggr, fn(aggr_item) ->
          Enum.map(
            Enum.at(result, i),
            fn(new_item) -> aggr_item <> new_item end
          )
        end)
      end
    )
  end

  def v_recursive(data) do
    recursive(data, length(data), 1, List.first(data))
  end

  def recursive(data, depth, cur_depth, list) when depth == cur_depth do
    list
  end

  def recursive(data, depth, cur_depth, list) do
    res = Enum.flat_map(list, fn(aggr_item) ->
      Enum.map(
        Enum.at(data, cur_depth),
        fn(new_item) -> aggr_item <> new_item end
      )
    end)
    recursive(data, depth, cur_depth + 1, res)
  end
end
