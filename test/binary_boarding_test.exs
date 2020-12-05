defmodule BinaryBoardingTest do
  use ExUnit.Case

  test "parsing" do
    assert {44, 5} == BinaryBoarding.parse("FBFBBFFRLR")
    assert {70, 7} == BinaryBoarding.parse("BFFFBBFRRR")
    assert {14, 7} == BinaryBoarding.parse("FFFBBBFRRR")
    assert {102, 4} == BinaryBoarding.parse("BBFFBBFRLL")
  end

  test "seatID" do
    assert 357 == BinaryBoarding.id({44, 5})
    assert 567 == BinaryBoarding.id({70, 7})
    assert 119 == BinaryBoarding.id({14, 7})
    assert 820 == BinaryBoarding.id({102, 4})
  end
end
