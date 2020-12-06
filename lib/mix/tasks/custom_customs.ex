defmodule Mix.Tasks.CustomCustoms do
  use Mix.Task

  @shortdoc "Per group count the unique or shared answers and return the sum"

  @moduledoc """
  Given the input file priv/input_06.txt report the sum of unique (default) or shared answers per group

  ## Example

  mix custom_customs (--shared)
  """

  def run([]) do
    print_sum(&get_unique/1)
  end

  def run(["--shared"]) do
    print_sum(&get_shared/1)
  end

  def print_sum(count_fun) do
    File.stream!("priv/input_06.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> Enum.join("\n")
    |> String.split("\n\n")
    |> Enum.map(count_fun)
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

  defp get_shared(group_input) do
    group_input = String.split(group_input, "\n")
    group_size = length(group_input)

    group_input
    |> Enum.map(&parse_answer/1)
    |> Enum.concat()
    |> Enum.frequencies()
    |> Enum.filter(fn {_key, cnt} -> cnt == group_size end)
  end

  defp parse_answer(answer) do
    answer
    |> String.graphemes()
    |> Enum.sort()
  end
end
