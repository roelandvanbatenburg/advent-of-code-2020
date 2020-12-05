defmodule Mix.Tasks.BinaryBoarding do
  use Mix.Task

  @shortdoc "Parse boarding passes"

  @moduledoc """
  Given the input file priv/input_05.txt find the largest seat ID

  ## Example

  mix binary_boarding
  """

  def run([]) do
    File.stream!("priv/input_05.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(&BinaryBoarding.seat_id/1)
    |> Enum.to_list()
    |> Enum.max()
    |> Integer.to_string()
    |> Mix.shell().info()
  end

  def run(["--empty"]) do
    seat_ids =
      File.stream!("priv/input_05.txt")
      |> Stream.map(&String.trim_trailing/1)
      |> Stream.map(&BinaryBoarding.seat_id/1)
      |> Enum.to_list()

    min = Enum.min(seat_ids)
    max = Enum.max(seat_ids)

    MapSet.difference(MapSet.new(min..max), MapSet.new(seat_ids))
    |> MapSet.to_list()
    |> List.first()
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
