defmodule Mix.Tasks.ShuttleSearch do
  use Mix.Task

  @shortdoc "Day 13"

  @moduledoc """
  Given the input file priv/input_13.txt find the bus

  ## Example

  mix shuttle_search (--part2)
  """

  alias ShuttleSearch.{PartOne, PartTwo}

  def run([]) do
    [timestamp_string, bus_line] =
      File.stream!("priv/input_13.txt")
      |> Stream.map(&String.trim_trailing/1)
      |> Enum.to_list()

    busses = PartOne.parse_bus_line(bus_line)
    timestamp = String.to_integer(timestamp_string)
    {depature_timestamp, bus_id} = PartOne.find_bus(timestamp, busses)

    ((depature_timestamp - timestamp) * bus_id)
    |> Integer.to_string()
    |> Mix.shell().info()
  end

  def run(["--part2"]) do
    [_timestamp_string, bus_line] =
      File.stream!("priv/input_13.txt")
      |> Stream.map(&String.trim_trailing/1)
      |> Enum.to_list()

    busses = PartTwo.parse_bus_line(bus_line)

    PartTwo.find_subsequent(busses)
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
