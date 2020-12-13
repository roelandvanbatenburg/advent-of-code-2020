defmodule ShuttleSearchTest do
  use ExUnit.Case

  alias ShuttleSearch.{PartOne}

  setup _context do
    {:ok, busses: [7, 13, 59, 31, 19]}
  end

  test "find the shuttle part one", %{busses: busses} do
    assert {944, 59} == PartOne.find_bus(939, busses)
  end
end
