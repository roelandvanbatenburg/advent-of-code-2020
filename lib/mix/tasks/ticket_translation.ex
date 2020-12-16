defmodule Mix.Tasks.TicketTranslation do
  use Mix.Task

  @shortdoc "Day 16"

  @moduledoc """
  Given the input file priv/input_16.txt parse tickets

  ## Example

  mix ticket_translation (--part2)
  """

  alias TicketTranslation.{PartOne}

  def run([]) do
    File.stream!("priv/input_16.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> TicketTranslation.parse_input()
    |> PartOne.error_rate()
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
