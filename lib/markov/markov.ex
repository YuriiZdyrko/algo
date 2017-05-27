defmodule Markov do

  @moduledoc """
  Implementation of Markov chain algorithm
  Randomises text file content, based on character sequences in original file.
  """

  def run(order) do
    {:ok, str} = File.read("./lib/markov/sample")
    str = String.replace(str, ~r/\r|\n/, "")
    mapping = get_freqs(str, order)
    initial_seed = pick_initial_seed(mapping)
    process_seed(mapping, order, initial_seed)
  end

  def pick_initial_seed(mapping) do
    mapping
    |> Enum.into([])
    |> Enum.sort_by(fn({k, next}) -> -length(next) end)
    |> List.first
  end

  @doc """
  Given seed value and mapping, recursively build resulting string.
  Recursion will terminate when last element of original text is encountered.
  """
  defp process_seed(mapping, order, initial_seed, result \\ "")
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

  @doc """
  Returns mapping from prev fragment to array of possible next fragments.
  Example of return value for order 4
  %{"ine." => [" "], "ys " => ["a", "S"],
  """
  def get_freqs(str, order), do: get_freqs(str, order, String.length(str), 0, [])
  def get_freqs(str, _, len, curr_index, result) when curr_index >= len do
    result
    |> Enum.reduce(%{}, fn({k, v}, aggr) ->
      if Map.has_key?(aggr, k) do
        Map.put(aggr, k, Map.get(aggr, k) ++ [v])
      else
        Map.put(aggr, k, [v])
      end
    end)
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
