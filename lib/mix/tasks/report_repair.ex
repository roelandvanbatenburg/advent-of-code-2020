defmodule Mix.Tasks.ReportRepair do
  use Mix.Task

  @shortdoc "Given the input finds the two entries that sum to 2020 and returns the product"

  @moduledoc """
  Given the input finds the two entries that sum to 2020 and returns the product
  The input is given by a file which is the first argument

  ## Example

  mix report_repair input.txt
  """

  def run([input_file]) do
    File.stream!(input_file)
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.to_list()
    |> ReportRepair.run()
    |> Integer.to_string()
    |> Mix.shell().info()
  end

  def run(_args) do
    Mix.shell().error("Use mix report_repair input.txt")
  end
end
