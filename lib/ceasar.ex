defmodule Ceasare do

  import IEx

  def run do
    txt = "Hello world!"
    enc_key = 2
    encrypt(enc_key, txt)
  end

  def decode do
    txt = "Jgnnq yqtnf!"
    enc_key = -2
    encrypt(enc_key, txt)
  end

  def encrypt(enc_key, plain_text) do
    mappp = mapp(enc_key)
    plain_text
    |> String.graphemes
    |> Enum.map(&(
      case Map.has_key?(mappp, String.downcase(&1)) do
        true ->
          case String.downcase(&1) == &1 do
            true -> Map.get(mappp, &1)
            _ -> String.upcase(Map.get(mappp, String.downcase(&1)))
          end
        _ -> &1
      end
    ))
    |> Enum.join("")
    |> IO.inspect
  end

  def mapp(enc_key) do
    al = String.graphemes("abcdefghijklmnopqrstuvwxyz")
    al
    |> Enum.with_index
    |> Enum.reduce(%{}, fn({v, i}, acc) ->
      Map.put(
        acc,
        v,
        Enum.at(al, Integer.mod(i + enc_key, length(al)))
      )
    end)
  end
end
