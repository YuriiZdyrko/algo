defmodule MarkovTest do
  use ExUnit.Case
  doctest Markov

  setup do
    str =
      "As Gregor Samsa awoke one morning from uneasy dreams he found himself transformed in his bed into a gigantic insect."

    [str: str]
  end

  test "picks initial seed correctly", context do
    {seed, next_chars} = Markov.pick_initial_seed(Markov.get_freqs(context[:str], 2))
    set = MapSet.new(["g", " ", "t", "s"])
    assert {seed, set} == {"in", MapSet.new(next_chars)}
  end
end
