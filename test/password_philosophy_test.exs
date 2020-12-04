defmodule PasswordPhilosophyTest do
  use ExUnit.Case

  test "count the valid password" do
    assert 2 ==
             PasswordPhilosophy.run([
               "1-3 a: abcde",
               "1-3 b: cdefg",
               "2-9 c: ccccccccc"
             ])
  end
end
