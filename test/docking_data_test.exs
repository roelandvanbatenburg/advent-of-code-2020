defmodule DockingDataTest do
  use ExUnit.Case

  alias DockingData.{PartOne, PartTwo}

  test "Follow the instructions" do
    assert 165 ==
             [
               "mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X",
               "mem[8] = 11",
               "mem[7] = 101",
               "mem[8] = 0"
             ]
             |> PartOne.follow_program()
             |> DockingData.sum()
  end

  test "Follow the instructions part two" do
    assert 208 ==
             [
               "mask = 000000000000000000000000000000X1001X",
               "mem[42] = 100",
               "mask = 00000000000000000000000000000000X0XX",
               "mem[26] = 1"
             ]
             |> PartTwo.follow_program()
             |> DockingData.sum()
  end
end
