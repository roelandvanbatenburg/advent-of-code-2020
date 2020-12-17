defmodule Mix.Tasks.ConwayCubes do
  use Mix.Task

  @shortdoc "Day 17"

  @moduledoc """
  Given the input file priv/input_17.txt activate cubes

  ## Example

  mix conway_cubes (--part2)
  """

  alias ConwayCubes.{PartOne, PartTwo}

  def run([]) do
    File.stream!("priv/input_17.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> ConwayCubes.parse()
    |> PartOne.step(6)
    |> ConwayCubes.active()
    |> Integer.to_string()
    |> Mix.shell().info()
  end

  def run(["--part2"]) do
    File.stream!("priv/input_17.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> ConwayCubes.parse()
    |> PartTwo.step(6)
    |> ConwayCubes.active()
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
