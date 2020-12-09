defmodule Mix.Tasks.EncodingError do
  use Mix.Task

  @shortdoc "Encoding Error"

  @moduledoc """
  Given the input file priv/input_09.txt find the first non-matching number

  ## Example

  mix encoding_error
  """

  def run([]) do
    File.stream!("priv/input_09.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.to_list()
    |> EncodingError.find_first_non_valid()
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
