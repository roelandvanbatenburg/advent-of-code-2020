defmodule ReportRepairTest do
  use ExUnit.Case

  describe "in two" do
    test "finds the product" do
      assert 4036 == ReportRepair.run2([2, 0, 5, 2018, 7, 9])
    end

    test "nil when not possible" do
      assert nil == ReportRepair.run2([2, 0, 5, 2017, 7, 9])
    end
  end

  describe "in three" do
    test "finds the product" do
      assert 241_861_950 == ReportRepair.run3([1721, 979, 366, 299, 675, 1456])
    end
  end
end
