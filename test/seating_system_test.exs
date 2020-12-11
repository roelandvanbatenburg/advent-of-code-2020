defmodule SeatingSystemTest do
  use ExUnit.Case

  alias SeatingSystem.PartOne

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
end
