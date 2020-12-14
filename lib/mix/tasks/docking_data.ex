defmodule Mix.Tasks.DockingData do
  use Mix.Task

  @shortdoc "Day 14"

  @moduledoc """
  Given the input file priv/input_14.txt dock the ferry

  ## Example

  mix docking_data (--part2)
  """

  alias DockingData.{PartOne, PartTwo}

  def run([]) do
    "priv/input_14.txt"
    |> File.stream!()
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> PartOne.follow_program()
    |> DockingData.sum()
    |> Integer.to_string()
    |> Mix.shell().info()
  end

  def run(["--part2"]) do
    "priv/input_14.txt"
    |> File.stream!()
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> PartTwo.follow_program()
    |> DockingData.sum()
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
