defmodule Markov do
  import IEx

  def run(order) do
    {:ok, str} = File.read("./lib/markov/sample")
    str = String.replace(str, ~r/\r|\n/, "")
    mapping = get_mapping(str, order)
    initial_seed = pick_initial_seed(mapping)
    process_seed(mapping, order, initial_seed, "")
  end

  def get_mapping(str, order) do
    get_freqs(str, order, String.length(str), 0, [])
  end

  def pick_initial_seed(mapping) do
    mapping
    |> Enum.into([])
    |> Enum.sort_by(fn({k, next}) -> -length(next) end)
    |> List.first
  end

  defp process_seed(mapping, order, {curr_seed, curr_seed_next} = next, result) do
    curr_seed_next = mapping[curr_seed]
    if (curr_seed_next == nil || curr_seed_next == [nil]) do
      result
    else
      step_result_next = Enum.random(curr_seed_next)
      next_seed = String.replace(curr_seed, ~r/^./, "") <> step_result_next
      process_seed(
        mapping,
        order,
        {next_seed, mapping[next_seed]},
        result <> step_result_next
      )
    end
  end

  def get_freqs(str, _, len, curr_index, result) when curr_index >= len do
    res = result
    |> Enum.reduce(%{}, fn({k, v}, aggr) ->
      case Map.has_key?(aggr, k) do
        true -> Map.put(aggr, k, Map.get(aggr, k) ++ [v])
        _ -> Map.put(aggr, k, [v])
      end
    end)
    res
  end

  def get_freqs(str, order, len, curr_index, result) do
    slice_end = curr_index + order - 1
    slice = {
      String.slice(str, curr_index..slice_end),
      String.at(str, curr_index + order)
    }
    order_slices = result ++ [slice]
    get_freqs(str, order, len, curr_index + 1, order_slices)
  end
end
