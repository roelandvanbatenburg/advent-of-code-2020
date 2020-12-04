defmodule Mix.Tasks.TobogganTrajectory do
  use Mix.Task

  @shortdoc "Count the trees"

  @moduledoc """
  Given the input file priv/input_03.txt report the number of trees

  ## Example

  mix toboggan_trajectory
  mix toboggan_trajectory --multiple
  """

  def run([]) do
    File.stream!("priv/input_03.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> TobogganTrajectory.run()
    |> Integer.to_string()
    |> Mix.shell().info()
  end

  def run(["--multiple"]) do
    input =
      File.stream!("priv/input_03.txt")
      |> Stream.map(&String.trim_trailing/1)
      |> Enum.to_list()

    (TobogganTrajectory.run(input, [1, 1]) * TobogganTrajectory.run(input, [3, 1]) *
       TobogganTrajectory.run(input, [5, 1]) * TobogganTrajectory.run(input, [7, 1]) *
       TobogganTrajectory.run(input, [1, 2]))
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
