defmodule EncodingErrorTest do
  use ExUnit.Case

  test "find first non valid" do
    assert nil == EncodingError.find_first_non_valid(Enum.concat(1..25, [26]), 25)
    assert nil == EncodingError.find_first_non_valid(Enum.concat(1..25, [49]), 25)
    assert 100 == EncodingError.find_first_non_valid(Enum.concat(1..25, [100]), 25)
    assert 50 == EncodingError.find_first_non_valid(Enum.concat(1..25, [50]), 25)
  end

  test "find first non valid small preamble" do
    input = [35, 20, 15, 25, 47, 40, 62, 55, 65, 95, 102, 117, 150, 182, 127]
    assert 127 == EncodingError.find_first_non_valid(input, 5)
  end

  test "find min and max of contiguous set" do
    input = [35, 20, 15, 25, 47, 40, 62, 55, 65, 95, 102, 117, 150, 182, 127]
    assert [15, 47] == EncodingError.find_contiguous_set(127, input)
  end
end
