defmodule CrabCupsTest do
  use ExUnit.Case

  test "part 1" do
    assert "92658374" == [3, 8, 9, 1, 2, 5, 4, 6, 7] |> CrabCups.step(10) |> CrabCups.from_one()
    assert "67384529" == [3, 8, 9, 1, 2, 5, 4, 6, 7] |> CrabCups.step() |> CrabCups.from_one()
  end
end
