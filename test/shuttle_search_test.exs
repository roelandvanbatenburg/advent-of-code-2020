defmodule ShuttleSearchTest do
  use ExUnit.Case

  alias ShuttleSearch.{PartOne, PartTwo}

  setup _context do
    {:ok, busses: [7, 13, 59, 31, 19]}
  end

  test "find the shuttle part one", %{busses: busses} do
    assert {944, 59} == PartOne.find_bus(939, busses)
  end

  test "find the timestamp part two" do
    assert 3417 == PartTwo.parse_bus_line("17,x,13,19") |> PartTwo.find_subsequent()
    assert 754_018 == PartTwo.parse_bus_line("67,7,59,61") |> PartTwo.find_subsequent()
    assert 779_210 == PartTwo.parse_bus_line("67,x,7,59,61") |> PartTwo.find_subsequent()
    assert 1_261_476 == PartTwo.parse_bus_line("67,7,x,59,61") |> PartTwo.find_subsequent()
    assert 1_202_161_486 == PartTwo.parse_bus_line("1789,37,47,1889") |> PartTwo.find_subsequent()
  end
end
