defmodule SeatingSystemTest do
  use ExUnit.Case

  alias SeatingSystem.{PartOne, PartTwo}

  setup _context do
    {:ok,
     input: [
       "L.LL.LL.LL",
       "LLLLLLL.LL",
       "L.L.L..L..",
       "LLLL.LL.LL",
       "L.LL.LL.LL",
       "L.LLLLL.LL",
       "..L.L.....",
       "LLLLLLLLLL",
       "L.LLLLLL.L",
       "L.LLLLL.LL"
     ]}
  end

  describe "PartOne" do
    test "correctly determine final state", %{input: input} do
      assert 37 ==
               input
               |> SeatingSystem.parse_to_map()
               |> PartOne.stabilize()
               |> SeatingSystem.count_occupied()
    end
  end

  describe "PartTwo" do
    test "correctly determine final state", %{input: input} do
      assert 26 ==
               input
               |> SeatingSystem.parse_to_map()
               |> PartTwo.stabilize()
               |> SeatingSystem.count_occupied()
    end

    test "correctly become empty at the top" do
      # 0, 2 is incorrect
      # : #.##.##.##
      # : #######.##
      {start, _, _} =
        SeatingSystem.parse_to_map([
          "#.##.##.##",
          "#######.##"
        ])

      assert :empty == PartTwo.next_state(:occupied, start, 0, 2)
    end
  end
end
