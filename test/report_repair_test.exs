defmodule ReportRepairTest do
  use ExUnit.Case

  test "finds the product" do
    assert 4036 == ReportRepair.run([2, 0, 5, 2018, 7, 9])
  end

  test "nil when not possible" do
    assert nil == ReportRepair.run([2, 0, 5, 2017, 7, 9])
  end
end
