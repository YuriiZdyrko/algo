defmodule BstTest do
  use ExUnit.Case
  import Bst
  doctest Bst

  test "creates balanced BST from array" do
    expected = %{
      v: 3,
      left: %{
        v: 2,
        left: %{
          v: 1,
          left: nil,
          right: nil
        },
        right: nil
      },
      right: %{
        v: 4,
        left: nil,
        right: nil
      }
    }

    assert Bst.from_array([1, 2, 3, 4]) == expected
  end

  test "has_value/2 returns correct result" do
    bst = from_array(Enum.into(200..230, []))
    assert Bst.has_value(bst, 220) == true
    assert Bst.has_value(bst, 300) == false
  end

  test "insert/2 inserts value" do
    bst = from_array(Enum.into(200..230, []))
    inserted = Bst.insert(bst, 300)
    assert Bst.has_value(inserted, 300) == true
  end

  test "node_lvl_txt/1 returns correct string" do
    expected = "1 > (nil 2)"
    result = Bst.node_lvl_txt(%{v: 1, right: %{v: 2}, left: nil})

    assert result == expected
  end

  test "remove/2 removes node" do
    bst = from_array(Enum.into(200..230, []))
    removed = Bst.remove(bst, 220)
    assert Bst.has_value(removed, 220) == false
  end
end
