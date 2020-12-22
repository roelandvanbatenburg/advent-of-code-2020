defmodule Mix.Tasks.CrabCombat do
  use Mix.Task

  @shortdoc "Day 22"

  @moduledoc """
  Given the input file priv/input_22.txt play combat

  ## Example

  mix crab_combat (--part2)
  """

  alias CrabCombat.{PartOne}

  def run([]) do
    File.stream!("priv/input_22.txt")
    |> Enum.to_list()
    |> Enum.join()
    |> CrabCombat.parse()
    |> PartOne.play()
    |> CrabCombat.score()
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
