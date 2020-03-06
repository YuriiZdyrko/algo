defmodule ClosestAndSmallest do
  def run do
    closest("456899 50 11992 176 272293 163 389128 96 290193 85 52")
  end

  def closest(""), do: [{}, {}]

  def closest(s) do
    # Transforms string into [{sum, pos, number}, ...]
    arr =
      String.split(s, " ")
      |> Enum.with_index()
      |> Enum.map(fn {num, idx} ->
        {
          Enum.sum(Integer.digits(String.to_integer(num))),
          idx,
          String.to_integer(num)
        }
      end)

    arr

    # Lists all possible combinations with their diffs [{pos1, pos2, diff}, ...]
    |> Enum.flat_map(fn {sum1, idx, _} ->
      {_, rest} = Enum.split(arr, idx + 1)

      Enum.map(rest, fn {sum2, idx2, _} ->
        {idx, idx2, to_positive(sum2 - sum1)}
      end)
    end)

    # Returns smallest diff {pos1, pos2, diff}
    |> Enum.reduce({0, 0, :infinity}, fn {pos1, pos2, diff} = curr,
                                         {p_pos1, p_pos2, smallest} = prev ->
      {sum, _, _} = Enum.at(arr, pos1)
      {sum2, _, _} = Enum.at(arr, pos2)
      {sum_prev, _, _} = Enum.at(arr, p_pos1)
      {sum2_prev, _, _} = Enum.at(arr, p_pos2)

      if diff < smallest ||
           (diff == smallest && sum_prev + sum2_prev > sum + sum2),
         do: curr,
         else: prev
    end)

    # Prints result
    |> (fn {pos1, pos2, _} ->
          [Enum.at(arr, pos1), Enum.at(arr, pos2)]
          |> Enum.sort_by(fn {sum, _, _} -> sum end)
        end).()
  end

  defp to_positive(n) when n < 0, do: -n
  defp to_positive(n), do: n
end
