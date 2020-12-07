defmodule Mix.Tasks.HandyHaversacks do
  use Mix.Task

  @shortdoc "Find shiny gold"

  @moduledoc """
  Given the input file priv/input_07.txt find how many bags can contain shiny gold
  or how many bags are inside the shiny gold (--size)

  ## Example

  mix handy_haversacks (--size)
  """

  def run([]) do
    File.stream!("priv/input_07.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> HandyHaversacks.number_of_bags_covering_gold()
    |> Integer.to_string()
    |> Mix.shell().info()
  end

  def run(["--size"]) do
    File.stream!("priv/input_07.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> HandyHaversacks.number_of_bags_in_gold()
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
