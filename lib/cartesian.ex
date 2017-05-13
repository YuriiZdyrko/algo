defmodule Cartesian do
  def run do
    cartesian(MapSet.new(["A", "B", "C"]), MapSet.new(["D", "E"]))
  end

  def cartesian(c1, c2) do
    MapSet.to_list(c1)
    |> Enum.flat_map(fn(i) ->
      Enum.map(MapSet.to_list(c2), &(
        MapSet.new([i, &1])
      ))
    end)
  end
end
