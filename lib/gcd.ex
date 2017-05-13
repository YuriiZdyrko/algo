defmodule Gcd do
  import IEx

  def run do
    gcd(16, 4)
  end

  def gcd(a, 0) do
    a
  end

  def gcd(a, b) do
    IO.inspect("#{a}, #{b}")
    gcd(b, Integer.mod(a, b))
  end
end
