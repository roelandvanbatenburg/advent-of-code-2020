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
end
