defmodule Mix.Tasks.AllergenAssessment do
  use Mix.Task

  @shortdoc "Day 21"

  @moduledoc """
  Given the input file priv/input_21.txt get some food

  ## Example

  mix allergen_assessment (--part2)
  """

  alias AllergenAssessment.{PartOne, PartTwo}

  def run([]) do
    File.stream!("priv/input_21.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> AllergenAssessment.parse()
    |> PartOne.count_non_allergen_ingredients()
    |> Integer.to_string()
    |> Mix.shell().info()
  end

  def run(["--part2"]) do
    File.stream!("priv/input_21.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> AllergenAssessment.parse()
    |> PartTwo.canonical_dangerous_ingredient_list()
    |> Mix.shell().info()
  end
end
