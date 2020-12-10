defmodule AdapterArrayTest do
  use ExUnit.Case

  test "use every adapter small set" do
    input = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
    assert {7, 0, 5, 22} == AdapterArray.use_every_adapter(input)
  end

  test "use every adapter larger set" do
    input1 = [28, 33, 18, 42, 31, 14, 46, 20, 48, 47, 24, 23, 49, 45]
    input2 = [19, 38, 39, 11, 1, 32, 25, 35, 8, 17, 7, 9, 4, 2, 34, 10, 3]

    assert {22, 0, 10, 52} == AdapterArray.use_every_adapter(input1 ++ input2)
  end
end
