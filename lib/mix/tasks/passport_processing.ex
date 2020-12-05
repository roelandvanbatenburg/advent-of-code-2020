defmodule Mix.Tasks.PassportProcessing do
  use Mix.Task

  @shortdoc "Count the valid passports"

  @moduledoc """
  Given the input file priv/input_04.txt report the number of valid passports

  ## Example

  mix passport_processing
  """

  def run([]) do
    File.stream!("priv/input_04.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> PassportProcessing.run()
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
