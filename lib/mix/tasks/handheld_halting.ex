defmodule Mix.Tasks.HandheldHalting do
  use Mix.Task

  @shortdoc "Fix the handheld"

  @moduledoc """
  Given the input file priv/input_08.txt find the value of the last instruction before entering the last loop

  ## Example

  mix handheld_halting
  """

  def run([]) do
    File.stream!("priv/input_08.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> HandheldHalting.run()
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
