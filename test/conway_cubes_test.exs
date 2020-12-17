defmodule ConwayCubesTest do
  use ExUnit.Case

  alias ConwayCubes.{PartOne, PartTwo}

  setup _context do
    {:ok,
     input: [
       ".#.",
       "..#",
       "###"
     ]}
  end

  test "active after 6 steps part 1", %{input: input} do
    assert 112 ==
             ConwayCubes.parse(input)
             |> PartOne.step(6)
             |> ConwayCubes.active()
  end

  test "active after 6 steps part 2", %{input: input} do
    assert 848 ==
             ConwayCubes.parse(input)
             |> PartTwo.step(6)
             |> ConwayCubes.active()
  end
end
