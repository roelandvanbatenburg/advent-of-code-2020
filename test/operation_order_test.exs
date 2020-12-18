defmodule OperationOrderTest do
  use ExUnit.Case

  alias OperationOrder

  test "get the sum" do
    assert [26] == ["2 * 3 + (4 * 5)"] |> OperationOrder.calculate()
    assert [437] == ["5 + (8 * 3 + 9 + 3 * 4 * 3)"] |> OperationOrder.calculate()
    assert [12_240] == ["5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))"] |> OperationOrder.calculate()

    assert [13_632] ==
             ["((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"] |> OperationOrder.calculate()
  end
end
