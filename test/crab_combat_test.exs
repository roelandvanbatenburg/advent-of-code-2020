defmodule CrabCombatTest do
  use ExUnit.Case

  alias CrabCombat.{PartOne}

  setup _context do
    {:ok,
     input: """
     Player 1:
     9
     2
     6
     3
     1

     Player 2:
     5
     8
     4
     7
     10
     """}
  end

  test "play combat part one", %{input: input} do
    assert 306 ==
             input
             |> CrabCombat.parse()
             |> PartOne.play()
             |> CrabCombat.score()
  end
end
