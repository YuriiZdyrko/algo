defmodule Godel do

  require Integer
  def run do
    {int, _} = Integer.parse(IO.gets("PLEASE..."))
    godel(int, 0)
  end

  def godel(int, steps) do
    if (int == 1) do
      IO.puts(int)
    else

      case Integer.is_even(round(int)) do
        true ->
          IO.inspect(int/2)
          godel(int/2, steps + 1)
        false ->
          IO.inspect(3*int + 1)
          godel(3*int + 1, steps + 1)
      end
    end
  end
end
