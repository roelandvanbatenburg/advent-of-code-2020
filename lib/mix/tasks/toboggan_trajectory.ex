defmodule Mix.Tasks.TobogganTrajectory do
  use Mix.Task

  @shortdoc "Count the trees"

  @moduledoc """
  Given the input file priv/input_03.txt report the number of trees

  ## Example

  mix toboggan_trajectory
  """

  def run([]) do
    File.stream!("priv/input_03.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> TobogganTrajectory.run()
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
