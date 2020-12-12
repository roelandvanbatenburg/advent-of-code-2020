defmodule RainRiskTest do
  use ExUnit.Case

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

  test "follow the instructions", %{input: input} do
    assert 25 ==
             input
             |> RainRisk.follow_instructions()
             |> RainRisk.manhattan_distance()
  end
end
