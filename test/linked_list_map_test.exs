defmodule LinkedListMapTest do
  use ExUnit.Case
  doctest LinkedListMap

  @list %{
    value: 1,
    next: %{
      value: 2,
      next: %{
        value: 3,
        next: nil
      }
    }
  }

  @reversed %{
    value: 3,
    next: %{
      value: 2,
      next: %{
        value: 1,
        next: nil
      }
    }
  }

  @inserted %{
    value: 1,
    next: %{
      value: 2,
      next: %{
        value: "inserted",
        next: %{
          value: 3,
          next: nil
        }
      }
    }
  }

  test "reverses list" do
    assert LinkedListMap.reverse(@list) == @reversed
  end

  test "inserts node" do
    assert LinkedListMap.insert(@list, 2, "inserted") == @inserted
  end
end
