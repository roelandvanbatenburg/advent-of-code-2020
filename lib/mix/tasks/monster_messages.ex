defmodule Mix.Tasks.MonsterMessages do
  use Mix.Task

  @shortdoc "Day 19"

  @moduledoc """
  Given the input file priv/input_19.txt fix the messages

  ## Example

  mix monster_messages (--part2)
  """

  alias MonsterMessages.{PartOne, PartTwo}

  def run([]) do
    File.stream!("priv/input_19.txt")
    |> Enum.to_list()
    |> Enum.join()
    |> MonsterMessages.parse()
    |> PartOne.valid_messages()
    |> Integer.to_string()
    |> Mix.shell().info()
  end

  def run(["--part2"]) do
    File.stream!("priv/input_19.txt")
    |> Enum.to_list()
    |> Enum.join()
    |> MonsterMessages.parse()
    |> PartTwo.valid_messages()
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
