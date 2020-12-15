defmodule RambunctiousRecitationTest do
  use ExUnit.Case

  alias RambunctiousRecitation.{PartOne}

  test "part 1" do
    assert 1 == PartOne.speak([1, 3, 2])
    assert 10 == PartOne.speak([2, 1, 3])
    assert 27 == PartOne.speak([1, 2, 3])
    assert 78 == PartOne.speak([2, 3, 1])
    assert 438 == PartOne.speak([3, 2, 1])
    assert 1836 == PartOne.speak([3, 1, 2])
  end
end
