defmodule Mix.Tasks.RambunctiousRecitation do
  use Mix.Task

  @shortdoc "Day 15"

  @moduledoc """
  Given the input return the 2020 number spoken

  ## Example

  mix rambunctious_recitation
  """

  alias RambunctiousRecitation.{PartOne}

  def run([]) do
    [1, 0, 18, 10, 19, 6]
    |> PartOne.speak()
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
