defmodule Histogram do

  @data [
    1,
    2,
    12,
    10,
    15,
    33,
    4
  ]

  def run do
    @data
    |> Enum.reduce(%{},
      fn(n, list) ->
        new_val = case Map.get(list, round(n/10)) do
          nil -> 1
          number -> number + 1
        end
        IO.inspect(round(n/10))
        Map.put(
          list,
          round(n/10),
          new_val
        )
      end
    )
    |> Enum.map(fn{k, v} ->
      result = 1..v
      |> Enum.map(
        fn(i) -> "*" end
      ) |>
      Enum.join
      IO.puts("#{k * 10} ... #{k * 10 + 10} - #{result}")
    end)
  end
end
