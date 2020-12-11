defmodule Mix.Tasks.SeatingSystem do
  use Mix.Task

  @shortdoc "Find the best seat"

  @moduledoc """
  Given the input file priv/input_11.txt find the final state of the seating area

  ## Example

  mix seating_system
  """

  def run([]) do
    File.stream!("priv/input_11.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> SeatingSystem.stabilize()
    |> SeatingSystem.count_occupied()
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
