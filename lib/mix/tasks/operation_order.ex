defmodule Mix.Tasks.OperationOrder do
  use Mix.Task

  @shortdoc "Day 17"

  @moduledoc """
  Given the input file priv/input_18.txt get the result

  ## Example

  mix operation_order (--part2)
  """

  alias OperationOrder

  def run([]) do
    File.stream!("priv/input_18.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> OperationOrder.calculate()
    |> Enum.sum()
    |> Integer.to_string()
    |> Mix.shell().info()
  end

  def run(["--part2"]) do
    File.stream!("priv/input_18.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> OperationOrder.calculate()
    |> Enum.sum()
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
