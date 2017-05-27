defmodule LinkedListMap do

  @moduledoc """
  Accepts list in format
  %{
    value: 1,
    next: %{
      value: 2,
      next: %{
        value: 3,
        next: nil
      }
    }
  }
  """

  def reverse(list) do
    first = Map.put(list, :next, nil)
    reverse_iterator(first, list.next)
  end

  def reverse_iterator(prev, curr) do
    case(curr.next) do
      nil -> Map.put(curr, :next, prev)
      _ -> reverse_iterator(Map.put(curr, :next, prev), curr.next)
    end
  end

  def insert(list, after_val, val) do
    insert_iterator([list.value], list, after_val, val)
  end

  def insert_iterator(prev, curr, after_val, val) do
    case(curr.value) do

      curr_val when curr_val == after_val ->
        IO.puts("Match found: #{curr_val}, inserting #{val}")

        # Because I didn't find a way to insert into Map at arbitrary depth,
        # convert map to_list first, then concatenate, then convert back to_nested_map
        # P.S. Stupid!
        tail = to_list(%{
          value: val,
          next: curr.next
        }, [])
        to_nested_map(prev ++ tail, %{})

      _ ->
        insert_iterator(
          prev ++ [curr.next.value],
          curr.next,
          after_val,
          val
        )
    end
  end

  def to_list(map, list) do
    result = list ++ [map.value]
    case(map.next) do
      nil -> result
      _ -> to_list(map.next, result)
    end
  end

  def to_nested_map(list, result) do
    list
    |> Enum.reverse
    |> Enum.reduce(%{}, fn(i, j) ->
      next = case j do
        %{} when map_size(j) == 0 ->
          nil
        _ -> j
      end
      %{
        value: i,
        next: next
      }
    end)
  end
end
