defmodule Bst do
  @moduledoc """
  Binary Search Tree implementation
  """

  def from_array([]), do: nil
  def from_array([v]), do: %{left: nil, right: nil, v: v}

  def from_array(arr) do
    middle_i = round(length(arr) / 2)
    {left, [h | right]} = Enum.split(arr, middle_i)
    %{left: from_array(left), right: from_array(right), v: h}
  end

  def print_graph(bst) do
    IO.puts(bst.v)
    do_print([bst.left])
    do_print([bst.right])
  end

  def do_print(nodes) do
    if !Enum.all?(nodes, fn i -> i == nil end) do
      nodes
      |> Enum.reduce("", fn node, lvl_txt ->
        lvl_txt <> node_lvl_txt(node) <> "  "
      end)
      |> (fn v ->
            IO.puts("#{String.duplicate("  ", round(:math.log2(length(nodes))))} #{v}")
          end).()

      nodes
      |> Enum.flat_map(fn i ->
        left = if i, do: i.left, else: nil
        right = if i, do: i.right, else: nil
        [left, right]
      end)
      |> do_print
    end
  end

  def insert(nil, new_value), do: %{v: new_value, right: nil, left: nil}

  def insert(bst, new_value) do
    cond do
      bst.v < new_value -> %{v: bst.v, right: insert(bst.right, new_value), left: bst.left}
      bst.v > new_value -> %{v: bst.v, right: bst.right, left: insert(bst.left, new_value)}
      bst.v == new_value -> bst
    end
  end

  def has_value(nil, _), do: false

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
    if bst.left && bst.left.left do
      %{v: bst.v, left: find_smallest(bst.left), right: bst.right}
    else
      bst.left.v
    end
  end

  def node_lvl_txt(nil), do: ""

  def node_lvl_txt(lvl) do
    "#{lvl.v} > (#{(lvl.left && lvl.left.v) || "nil"} #{(lvl.right && lvl.right.v) || "nil"})"
  end
end
