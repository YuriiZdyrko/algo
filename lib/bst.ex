defmodule Bst do

  import IEx

  def run do
    bst = from_array(Enum.into(200..222, []))
    print_graph(bst)
  end


  def from_array([]) do
    nil
  end
  def from_array(arr) when length(arr) == 1 do
    [v] = arr
    %{left: nil, right: nil, v: v}
  end
  def from_array(arr) do
    middle_i = round(length(arr) / 2)
    {left, [h|right]} = Enum.split(arr, middle_i)
    %{left: from_array(left), right: from_array(right), v: h}
  end

  def print_graph(bst) do
    IO.puts(bst.v)
    do_print([bst.left])
    do_print([bst.right])
  end

  def do_print(nodes) do
    if (Enum.all?(nodes, fn(i) -> i == nil end)) do
      "（。 ㅅ 。）"
    else
      nodes
      |> Enum.reduce("", fn(node, lvl_txt) ->
        lvl_txt <> node_lvl_txt(node) <> "  "
      end)
      |> (fn(v) ->
        IO.puts("#{String.duplicate("  ", round(:math.log2(length(nodes))))} #{v}")
      end).()

      nodes
      |> Enum.flat_map(fn(i) ->
        left = if (i), do: i.left, else: nil
        right = if (i), do: i.right, else: nil
        [left, right]
      end)
      |> do_print

    end
  end

  def replace_nil_with_empty_array(list) do
    Enum.filter(list, fn(i) -> i !== nil end)
  end

  def node_lvl_txt(nil) do
    "(leaf)"
  end
  def node_lvl_txt(lvl) do
    "#{lvl.v} > (#{lvl.left && lvl.left.v} #{lvl.right && lvl.right.v})"
  end
end
