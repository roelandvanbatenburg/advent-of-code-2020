defmodule Mix.Tasks.AdapterArray do
  use Mix.Task

  @shortdoc "Adapter Array"

  @moduledoc """
  Given the input file priv/input_10.txt find the chain of all adapters or all possible chains

  ## Example

  mix adapter_array (--count)
  """

  def run([]) do
    {ones, _twos, threes, _last} =
      File.stream!("priv/input_10.txt")
      |> Stream.map(&String.trim_trailing/1)
      |> Stream.map(&String.to_integer/1)
      |> Enum.to_list()
      |> AdapterArray.use_every_adapter()

    (ones * threes)
    |> Integer.to_string()
    |> Mix.shell().info()
  end

  def run(["--count"]) do
    File.stream!("priv/input_10.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.to_list()
    |> AdapterArray.count_all_solutions()
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
