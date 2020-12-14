defmodule DockingDataTest do
  use ExUnit.Case

  alias DockingData.{PartOne}

  setup _context do
    {:ok,
     input: [
       "mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X",
       "mem[8] = 11",
       "mem[7] = 101",
       "mem[8] = 0"
     ]}
  end

  test "Follow the instructions", %{input: input} do
    assert 165 ==
             input
             |> PartOne.follow_program()
             |> PartOne.sum()
  end
end
