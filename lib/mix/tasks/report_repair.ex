defmodule Mix.Tasks.ReportRepair do
  use Mix.Task

  @shortdoc "Given the input finds the 2 or 3 entries that sum to 2020 and returns the product"

  @moduledoc """
  Given the input finds the two or three entries that sum to 2020 and returns the product
  The input is given by a file which is the first argument

  ## Example

  mix report_repair 2 priv/input_01.txt
  mix report_repair 3 priv/input_01.txt
  """

  def run(["2", input_file]) do
    File.stream!(input_file)
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.to_list()
    |> ReportRepair.run2()
    |> Integer.to_string()
    |> Mix.shell().info()
  end

  def run(["3", input_file]) do
    File.stream!(input_file)
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.to_list()
    |> ReportRepair.run3()
    |> Integer.to_string()
    |> Mix.shell().info()
  end

  def run(_args) do
    Mix.shell().error("Use mix report_repair 2 input.txt")
  end
end
