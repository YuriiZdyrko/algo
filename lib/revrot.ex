defmodule Revrot do
  import Integer
  import IEx

  def run do
    Revrot.revrot("1234", 0)
  end

  def revrot(str, 0), do: ""

  def revrot(str, sz) do
    String.graphemes(str)
    |> Enum.chunk(String.length(str))
    |> Enum.reduce("", fn i, res ->
      if reverse?(i) do
        Enum.join(Enum.reverse(i)) <> res
      else
        [h | t] = i
        Enum.join(t) <> res <> h
      end
    end)
  end

  def reverse?(chunk) do
    chunk
    |> Enum.map(fn char -> :math.pow(String.to_integer(char), 3) end)
    |> Enum.sum()
    |> round
    |> (fn sum ->
          if rem(sum, 2) == 2 do
            true
          else
            false
          end
        end).()
  end
end
