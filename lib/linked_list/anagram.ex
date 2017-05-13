defmodule Anagram do

  def run do
    List.flatten(List.duplicate(["lala", "mama", "bebe", "amam", "alla"], 10000))
    |> process_list(%{})
    |> Enum.reduce([], fn({k, v}, res) ->
      res ++ [{k, length(v)}]
    end)
  end

  def process_list([h|t], result) do
    key = get_map_key(h)
    new_result = case Map.has_key?(result, key) do
      true -> Map.put(result, key, result[key] ++ [key])
      _ -> Map.put(result, key, [key])
    end
    process_list(t, new_result)
  end
  def process_list([], result), do: result

  def get_map_key(str) do
    str
    |> String.graphemes
    |> Enum.sort
    |> List.to_string
  end
end
