defmodule Mix.Tasks.JurassicJigsaw do
  use Mix.Task

  @shortdoc "Day 19"

  @moduledoc """
  Given the input file priv/input_20.txt combine the tiles

  ## Example

  mix jurassic_jigsaw (--part2)
  """

  alias JurassicJigsaw.{Grid, PartOne, PartTwo}

  def run([]) do
    File.stream!("priv/input_20.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> Enum.join("\n")
    |> String.trim()
    |> JurassicJigsaw.parse()
    |> Grid.build_grid()
    |> PartOne.multiply_corners()
    |> Integer.to_string()
    |> Mix.shell().info()
  end

  def run(["--part2"]) do
    File.stream!("priv/input_20.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> Enum.join("\n")
    |> String.trim()
    |> JurassicJigsaw.parse()
    |> Grid.build_grid()
    |> PartTwo.roughness()
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
