defmodule TobogganTrajectoryTest do
  use ExUnit.Case

  setup _context do
    {:ok,
     input: [
       "..##.......",
       "#...#...#..",
       ".#....#..#.",
       "..#.#...#.#",
       ".#...##..#.",
       "..#.##.....",
       ".#.#.#....#",
       ".#........#",
       "#.##...#...",
       "#...##....#",
       ".#..#...#.#"
     ]}
  end

  test "find the path", %{input: input} do
    assert 7 == TobogganTrajectory.run(input)
  end

  test "test multipe paths", %{input: input} do
    assert 336 =
             TobogganTrajectory.run(input, [1, 1]) * TobogganTrajectory.run(input, [3, 1]) *
               TobogganTrajectory.run(input, [5, 1]) * TobogganTrajectory.run(input, [7, 1]) *
               TobogganTrajectory.run(input, [1, 2])
  end
end
