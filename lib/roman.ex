defmodule Roman do
  @mapping [{"I", "V"}, {"X", "L"}, {"C", "D"}, {"M", "V_dash"}, {"Y", "Y_dash"}]

  def run do
    solution(1)
  end

  def solution(0), do: ""

  def solution(n) do
    digits = Integer.digits(n)

    digits
    |> Enum.with_index()
    |> Enum.map(fn {n, i} ->
      (Integer.to_string(n) <> String.duplicate("0", length(digits) - i - 1))
      |> String.to_integer()
      |> rounded_number_to_roman
    end)
    |> Enum.join()
    |> to_charlist
  end

  def rounded_number_to_roman(n) do
    len = length(Integer.digits(n))
    {one, half} = Enum.at(@mapping, len - 1)
    {one_nxt, _} = Enum.at(@mapping, len)
    [h | _] = Integer.digits(n)

    cond do
      h < 4 -> String.duplicate(one, h)
      h == 4 -> one <> half
      h == 5 -> half
      h > 5 && h < 9 -> half <> String.duplicate(one, h - 5)
      h == 9 -> one <> one_nxt
    end
  end
end
