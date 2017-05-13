defmodule QuickSort do
  def run do
    arr = [2,3,4,222,444,888,333,1,5,20,999,2222]
    sort(arr)
  end


  def sort(arr) when length(arr) < 2 do
    pr(arr)
  end
  def sort(arr) do
    {sorted, pvt_i} = split(arr)
    :timer.sleep(100)
    {h, t} = Enum.split(sorted, pvt_i)
    IO.puts("<sort_step")
    IO.inspect(h)
    IO.inspect(t)
    IO.puts(">")
    sort(h)
    sort(t)
  end

  def pr(arr) do
    IO.puts("_______________ #{inspect arr}")
  end

  def split(arr) do
    split(arr, Enum.at(arr, length(arr) - 1), length(arr) - 1, 0)
  end

  def split(arr, pvt, pvt_i, curr_i) do
    IO.puts("split_step: #{inspect arr}")
    if (curr_i < pvt_i) do
      if Enum.at(arr, curr_i) > pvt do
        curr = Enum.at(arr, curr_i)

        # Move prev to start
        pre_pvt = Enum.at(arr, pvt_i - 1)
        curr_replaced_with_prev = List.update_at(arr, curr_i, fn(_) -> pre_pvt end)

        # Move pvt 1 down
        pvt_one_lvl_down = List.update_at(curr_replaced_with_prev, pvt_i - 1, fn(_) -> pvt end)

        # Move curr after pvt
        curr_after_pvt = List.update_at(pvt_one_lvl_down, pvt_i, fn(_) -> curr end)
        split(curr_after_pvt, pvt, pvt_i - 1, curr_i)
      else
        split(arr, pvt, pvt_i, curr_i + 1)
      end
    else
      IO.puts("result #{inspect arr}")
      {arr, pvt_i}
    end
  end
end
