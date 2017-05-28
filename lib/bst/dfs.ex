defmodule Dfs do

  @moduledoc """
  Depth-first search for Binary Search Tree
  """

  def run do
    bst =  Bst.from_array(200..230 |> Enum.into([]))
    dfs(bst, 220, [])
  end

  def dfs(nil, search_value, discovered), do: nil
  def dfs(edge, search_value, discovered) do
    IO.puts(edge.v)
    if (edge.v == search_value) do
      IO.puts("SUCCESS")
    else
      if (!Enum.member?(discovered, edge.v)) do
        Enum.each([edge.left, edge.right], fn(e) ->
          dfs(e, search_value, discovered ++ [edge.v])
        end)
      end
    end
  end
end
