defmodule BinaryBoardingTest do
  use ExUnit.Case

  test "seatID" do
    assert 357 == BinaryBoarding.seat_id("FBFBBFFRLR")
    assert 567 == BinaryBoarding.seat_id("BFFFBBFRRR")
    assert 119 == BinaryBoarding.seat_id("FFFBBBFRRR")
    assert 820 == BinaryBoarding.seat_id("BBFFBBFRLL")
  end
end
