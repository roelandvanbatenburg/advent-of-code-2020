defmodule CrabCombatTest do
  use ExUnit.Case

  alias CrabCombat.{PartOne, PartTwo}

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

  test "play recursive combat", %{input: input} do
    assert 291 ==
             input
             |> CrabCombat.parse()
             |> PartTwo.play()
             |> CrabCombat.score()
  end

  test "do not loop" do
    assert 105 ==
             """
                   Player 1:
             43
             19

             Player 2:
             2
             29
             14
             """
             |> CrabCombat.parse()
             |> PartTwo.play()
             |> CrabCombat.score()
  end
end
