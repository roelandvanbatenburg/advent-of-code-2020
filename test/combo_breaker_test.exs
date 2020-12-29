defmodule ComboBreakerTest do
  use ExUnit.Case

  test "part1" do
    assert 14_897_079 == ComboBreaker.get_encryption_key(5_764_801, 17_807_724)
  end
end
