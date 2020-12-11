defmodule Mix.Tasks.SeatingSystem do
  use Mix.Task

  @shortdoc "Find the best seat"

  @moduledoc """
  Given the input file priv/input_11.txt find the final state of the seating area

  ## Example

  mix seating_system (--part2)
  """

  def run([]) do
    File.stream!("priv/input_11.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> SeatingSystem.parse_to_map()
    |> SeatingSystem.PartOne.stabilize()
    |> SeatingSystem.count_occupied()
    |> Integer.to_string()
    |> Mix.shell().info()
  end

  def run(["--part2"]) do
    File.stream!("priv/input_11.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> SeatingSystem.parse_to_map()
    |> SeatingSystem.PartTwo.stabilize()
    |> SeatingSystem.count_occupied()
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
