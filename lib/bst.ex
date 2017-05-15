defmodule Bst do

  import IEx

  def run do
    bst = from_array(Enum.into(200..230, []))
    # print_graph(bst)
    # has_value(bst, 290)
    # print_graph(insert(bst, 240))
    removed = remove(bst, 203) # Should be replaced with smallest right (204)
    print_graph(removed)
  end


  def from_array([]) do
    nil
  end
  def from_array(arr) when length(arr) == 1 do
    [v] = arr
    %{left: nil, right: nil, v: v}
  end
  def from_array(arr) do
    middle_i = round(length(arr) / 2 - 1)
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

  def insert(nil, new_value) do
    %{v: new_value, right: nil, left: nil}
  end
  def insert(bst, new_value) do
    if !has_value(bst, new_value) do
      if (bst.v < new_value) do
        %{v: bst.v, right: insert(bst.right, new_value), left: bst.left}
      else
        %{v: bst.v, right: bst.right, left: insert(bst.left, new_value)}
      end
    else
      bst
    end
  end

  def has_value(nil, _) do
    false
  end
  def has_value(bst, search_value) do
    case bst.v do
      v when v == search_value -> true
      v when v < search_value -> has_value(bst.right, search_value)
      v when v > search_value -> has_value(bst.left, search_value)
    end
  end

  def remove(bst, v) do
    if has_value(bst, v), do: do_remove(bst, v), else: bst
  end
  def do_remove(bst, v) do
    cond do
      bst.v < v -> %{v: bst.v, right: do_remove(bst.right, v), left: bst.left}
      bst.v > v -> %{v: bst.v, right: bst.right, left: do_remove(bst.left, v)}
      true -> remove_top_most(bst)
    end
  end

  def remove_top_most(bst) do
    cond do
      bst.left == nil && bst.right == nil -> nil
      bst.left == nil && bst.right -> bst.right
      bst.right == nil && bst.left -> bst.left

      # Two children - in-place swap is needed
      bst.left && bst.right -> swap(bst)
    end
  end

  def swap(bst) do
    smallest = find_smallest(bst.right)
    no_smallest_right = remove(bst.right, smallest)
    %{v: smallest, right: no_smallest_right, left: bst.left}
  end

  def find_smallest(bst) do
    if (bst.left && bst.left.left) do
      %{v: bst.v, left: find_smallest(bst.left), right: bst.right}
    else
      bst.left.v
    end
  end

  def node_lvl_txt(nil) do
    ""
  end
  def node_lvl_txt(lvl) do
    "#{lvl.v} > (#{lvl.left && lvl.left.v || "x"} #{lvl.right && lvl.right.v || "x"})"
  end
end
