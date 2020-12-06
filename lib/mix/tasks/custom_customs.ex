defmodule Mix.Tasks.CustomCustoms do
  use Mix.Task

  @shortdoc "Per group count the unique answers and return the sum"

  @moduledoc """
  Given the input file priv/input_06.txt report the sum of unique answers per group

  ## Example

  mix custom_customs
  """

  def run([]) do
    File.stream!("priv/input_06.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> Enum.join("\n")
    |> String.split("\n\n")
    |> Enum.map(&get_unique/1)
    |> Enum.map(&length/1)
    |> Enum.sum()
    |> Integer.to_string()
    |> Mix.shell().info()
  end

  defp get_unique(group_input) do
    group_input
    |> String.split("\n")
    |> Enum.map(&parse_answer/1)
    |> Enum.concat()
    |> Enum.uniq()
  end

  defp parse_answer(answer) do
    answer
    |> String.graphemes()
    |> Enum.sort()
  end
end
