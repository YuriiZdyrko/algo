defmodule Base do
  def run do
    base(5)
  end

  def run_tail do
    tail(5, 5, 1)
  end


  def tail(n, 0, res) do
    res
  end
  def tail(n, i, res) do
    tail(n, i - 1, res * n)
  end

  def base(n) do
    case n do
      0 ->
        1
      other ->
        n * compute(n)
    end
  end

  def compute(n) do
    IO.inspect(n)
    :math.pow(n, n - 1)
  end
end
