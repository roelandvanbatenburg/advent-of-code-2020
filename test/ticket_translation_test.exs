defmodule TicketTranslationTest do
  use ExUnit.Case

  alias TicketTranslation.{PartOne, PartTwo}

  test "find error rate" do
    assert 71 ==
             [
               "class: 1-3 or 5-7",
               "row: 6-11 or 33-44",
               "seat: 13-40 or 45-50",
               "",
               "your ticket:",
               "7,1,14",
               "",
               "nearby tickets:",
               "7,3,47",
               "40,4,50",
               "55,2,20",
               "38,6,12"
             ]
             |> TicketTranslation.parse_input()
             |> PartOne.error_rate()
  end

  test "find solution" do
    assert %{"row" => 0, "class" => 1, "seat" => 2} ==
             [
               "class: 0-1 or 4-19",
               "row: 0-5 or 8-19",
               "seat: 0-13 or 16-19",
               "",
               "your ticket:",
               "11,12,13",
               "",
               "nearby tickets:",
               "3,9,18",
               "15,1,5",
               "100,1000,2000",
               "5,14,9"
             ]
             |> TicketTranslation.parse_input()
             |> TicketTranslation.filter_invalid_tickets()
             |> PartTwo.solve()
  end

  test "calculate solution" do
    ticket = [2, 5, 10]

    assert 50 ==
             PartTwo.departure_product(
               %{"row" => 0, "departure test" => 1, "departure" => 2},
               ticket
             )
  end
end
