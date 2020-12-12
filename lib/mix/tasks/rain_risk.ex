defmodule Mix.Tasks.RainRisk do
  use Mix.Task

  @shortdoc "Day 12"

  @moduledoc """
  Given the input file priv/input_12.txt the manhatten distance to the final destinantion

  ## Example

  mix rain_disk
  """

  def run([]) do
    File.stream!("priv/input_12.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> RainRisk.follow_instructions()
    |> RainRisk.manhattan_distance()
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
