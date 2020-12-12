defmodule RainRiskTest do
  use ExUnit.Case

  alias RainRisk.{PartOne, PartTwo}

  setup _context do
    {:ok,
     input: [
       "F10",
       "N3",
       "F7",
       "R90",
       "F11"
     ]}
  end

  test "follow the instructions part one", %{input: input} do
    assert 25 == input |> PartOne.follow_instructions() |> RainRisk.manhattan_distance()
  end

  test "follow the instructions part two", %{input: input} do
    assert 286 == input |> PartTwo.follow_instructions() |> RainRisk.manhattan_distance()
  end
end
