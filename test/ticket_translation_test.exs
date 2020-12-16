defmodule TicketTranslationTest do
  use ExUnit.Case

  alias TicketTranslation.{PartOne}

  setup _context do
    {:ok,
     input: [
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
     ]}
  end

  test "find error rate", %{input: input} do
    assert 71 == TicketTranslation.parse_input(input) |> PartOne.error_rate()
  end
end
