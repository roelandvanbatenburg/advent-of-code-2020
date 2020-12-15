defmodule Mix.Tasks.RambunctiousRecitation do
  use Mix.Task

  @shortdoc "Day 15"

  @moduledoc """
  Given the input return the 2020 number spoken

  ## Example

  mix rambunctious_recitation (--part2)
  """

  alias RambunctiousRecitation

  def run([]) do
    [1, 0, 18, 10, 19, 6]
    |> RambunctiousRecitation.speak()
    |> Integer.to_string()
    |> Mix.shell().info()
  end

  def run(["--part2"]) do
    [1, 0, 18, 10, 19, 6]
    |> RambunctiousRecitation.speak(30_000_000)
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
