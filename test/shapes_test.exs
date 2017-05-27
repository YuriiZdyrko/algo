defmodule ShapesTest do
  use ExUnit.Case
  doctest Shapes

  @shapes [
    [0,0,0,1,1,1,1,1,1,1,1],
    [0,1,0,0,1,1,1,1,1,1,1],
    [0,1,0,1,1,1,1,1,1,1,1],
    [1,1,0,1,1,1,1,1,1,1,1],
    [1,1,1,1,1,1,1,1,1,1,1],
    [1,1,1,1,1,1,1,1,1,1,1],
    [1,1,1,1,1,1,0,1,1,1,1],
    [1,1,1,1,0,0,0,1,1,1,1],
    [1,1,1,1,1,1,1,1,1,1,1],
    [1,1,1,1,1,1,1,1,1,1,1],
    [1,1,1,1,1,1,1,1,1,1,1]
  ]

  @cube1 MapSet.new([{0, 0}, {0, 1}, {0, 2}, {1, 0}, {1, 2}, {2, 0}, {2, 2}])


  test "check_all_dirs/2 returns correct number of 0 siblings" do
    assert Shapes.check_all_dirs(@shapes, {0, 0}, {0, 1}) == MapSet.new([{0, 0}])
    assert Shapes.check_all_dirs(@shapes, {0, 0}, {0, 0}) == MapSet.new([{0, 1}, {1, 0}])
    assert Shapes.check_all_dirs(@shapes, {0, 0}, {2, 2}) == MapSet.new([{1, 2}])
  end

  test "process_cube/1 returns shape if shape is found" do
    assert Shapes.process_cube(@cube1) == [{0, 0}, {0, 1}, {1, 0}, {2, 0}]
  end
end
