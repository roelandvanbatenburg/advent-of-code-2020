defmodule RambunctiousRecitationTest do
  use ExUnit.Case

  alias RambunctiousRecitation

  test "part 1" do
    assert 1 == RambunctiousRecitation.speak([1, 3, 2])
    assert 10 == RambunctiousRecitation.speak([2, 1, 3])
    assert 27 == RambunctiousRecitation.speak([1, 2, 3])
    assert 78 == RambunctiousRecitation.speak([2, 3, 1])
    assert 438 == RambunctiousRecitation.speak([3, 2, 1])
    assert 1836 == RambunctiousRecitation.speak([3, 1, 2])
  end
end
