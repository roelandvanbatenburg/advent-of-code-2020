defmodule PasswordPhilosophyTest do
  use ExUnit.Case

  setup _context do
    {:ok,
     input: [
       "1-3 a: abcde",
       "1-3 b: cdefg",
       "2-9 c: ccccccccc"
     ]}
  end

  test "count the valid password", %{input: input} do
    assert 2 == PasswordPhilosophy.run(input)
  end

  test "count the valid password weirdly", %{input: input} do
    assert 1 == PasswordPhilosophy.run(input, :weird)
  end
end
