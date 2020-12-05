defmodule Mix.Tasks.PassportProcessing do
  use Mix.Task

  @shortdoc "Count the valid passports"

  @moduledoc """
  Given the input file priv/input_04.txt report the number of valid passports
  --strict for part 2

  ## Example

  mix passport_processing (--strict)
  """

  def run([]) do
    File.stream!("priv/input_04.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> PassportProcessing.run()
    |> Integer.to_string()
    |> Mix.shell().info()
  end

  def run(["--strict"]) do
    File.stream!("priv/input_04.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> PassportProcessing.run(true)
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
