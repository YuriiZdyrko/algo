defmodule SelectionSort do

  def run do
    {t, v} = :timer.tc(fn() -> List.flatten(sort(Enum.into(1000..1, []))) end)
    IO.inspect("Time(ms): #{t/1000}")
    IO.inspect("Result: #{inspect v}")
  end

  def sort(list, low_bound \\ 0)
  def sort(list, low_bound) when low_bound == length(list) - 1 do
    list
  end

  def sort(list, low_bound) do
    sort_step_result = list
    |> find_smallest(low_bound)
    |> update_list(list, low_bound)

    sort(sort_step_result, low_bound + 1)
  end

  @doc """
  Finds smallest value in rest of list
  Returns {value, position} tuple
  """
  def find_smallest(list, low_bound) do
    list
    |> Enum.slice(low_bound..length(list) - 1)
    |> Enum.with_index
    |> Enum.sort
    |> List.first
    |> (fn({v, k}) -> {v, low_bound + k} end).()
  end

  @doc """
  Performs "mutation" of the list, by
  swapping current value with smallest found
  """
  def update_list({next_value, next_key}, list, low_bound) do
    list
    |> List.replace_at(low_bound, next_value)
    |> List.replace_at(next_key, Enum.at(list, low_bound))
  end
end
