defmodule Bfs do
  def run do
    bst =  Bst.from_array(200..230 |> Enum.into([]))
    bfs([bst], 220)
  end

  def bfs(nodes, search_value) do
    if (Enum.any?(nodes, fn(n) -> n.v == search_value end)) do
      IO.puts("SUCCESS")
    else
      IO.inspect(nodes |> Enum.map(fn(n) -> n.v end))
      bfs(Enum.flat_map(nodes, fn(n) ->
        [n.left, n.right]
      end), search_value)
    end
  end
end
