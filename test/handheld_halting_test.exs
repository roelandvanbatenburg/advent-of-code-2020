defmodule HandheldHaltingTest do
  use ExUnit.Case

  setup _context do
    {:ok,
     input: [
       "nop +0",
       "acc +1",
       "jmp +4",
       "acc +3",
       "jmp -3",
       "acc -99",
       "acc +1",
       "jmp -4",
       "acc +6"
     ]}
  end

  test "correctly determine output", %{input: input} do
    assert 5 == HandheldHalting.run(input)
  end

  test "correctly solves", %{input: input} do
    assert 8 = HandheldHalting.solve(input)
  end
end
