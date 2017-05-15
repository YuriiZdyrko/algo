defmodule Bst do

  import IEx

  def run do
    bst = from_array(Enum.into(200..230, []))
    # print_graph(bst)
    # has_value(bst, 290)
    print_graph(insert(bst, 240))

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

  def replace_nil_with_empty_array(list) do
    Enum.filter(list, fn(i) -> i !== nil end)
  end

  def node_lvl_txt(nil) do
    "(leaf)"
  end
  def node_lvl_txt(lvl) do
    "#{lvl.v} > (#{lvl.left && lvl.left.v || "x"} #{lvl.right && lvl.right.v || "x"})"
  end
end
