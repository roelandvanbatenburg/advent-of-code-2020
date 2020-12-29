defmodule Mix.Tasks.CrabCups do
  use Mix.Task

  @shortdoc "Day 23"

  @moduledoc """
  Given the input play Crab Cups

  ## Example

  mix crab_cups (--part2)
  """

  def run([]) do
    "538914762"
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> CrabCups.step()
    |> CrabCups.from_one()
    |> Mix.shell().info()
  end

  def run(["--part2"]) do
    "538914762"
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> CrabCups.init_lookup()
    |> CrabCups.step_with_lookup()
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
