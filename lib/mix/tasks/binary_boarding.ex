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
    |> Stream.map(&BinaryBoarding.parse/1)
    |> Stream.map(&BinaryBoarding.id/1)
    |> Enum.to_list()
    |> Enum.max()
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
