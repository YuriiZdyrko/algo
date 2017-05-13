defmodule MaximsCp do
  def run do
    do_run([])
  end

  def do_run(result) do
    str = IO.gets("0 or else")
    {n, _} = Integer.parse(str)

    IO.inspect(n)
    IO.inspect(n == 0)

    case n == 0 do
      true ->
        IO.inspect(Enum.max(result))
        IO.inspect(Enum.min(result))
      false ->
        do_run(result ++ [n])
    end
  end
end
