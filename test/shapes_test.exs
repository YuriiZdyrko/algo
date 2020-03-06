defmodule ShapesTest do
  use ExUnit.Case
  doctest Shapes

  @matrix [
    [0, 0, 0, 1, 1, 1, 1, 1, 1],
    [0, 1, 0, 1, 1, 1, 1, 1, 1],
    [0, 1, 0, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 0, 1, 1],
    [1, 1, 1, 1, 0, 0, 0, 1, 1],
    [1, 1, 1, 1, 1, 1, 0, 1, 1]
  ]

  @cube_zero_cells MapSet.new([{0, 0}, {0, 1}, {0, 2}, {1, 0}, {1, 2}, {2, 0}, {2, 2}])

  @cube_expected_shapes [
    MapSet.new([{0, 0}, {1, 0}, {2, 0}]),
    MapSet.new([{0, 2}, {1, 2}, {2, 2}]),
    MapSet.new([{0, 0}, {0, 1}, {0, 2}])
  ]

  test "check_all_dirs/2 returns siblings" do
    assert Shapes.get_relevant_siblings(@matrix, {0, 0}, {0, 0}) == MapSet.new([{1, 0}, {0, 1}])
    assert Shapes.get_relevant_siblings(@matrix, {0, 0}, {2, 2}) == MapSet.new([{1, 2}])
  end

  test "process_cube/1 returns found shapes" do
    result = Shapes.process_cube(@cube_zero_cells)
    assert Enum.all?(result, fn i -> Enum.member?(@cube_expected_shapes, i) end) == true
  end

  test "find/1 returns correct result" do
    expected =
      @cube_expected_shapes ++
        [
          MapSet.new([{7, 4}, {7, 5}, {7, 6}]),
          MapSet.new([{6, 6}, {7, 6}, {8, 6}])
        ]

    result = Shapes.find(@matrix)
    assert Enum.all?(result, fn i -> Enum.member?(expected, i) end) == true
  end
end
