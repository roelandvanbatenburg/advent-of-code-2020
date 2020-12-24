defmodule Mix.Tasks.LobbyLayout do
  use Mix.Task

  @shortdoc "Day 24"

  @moduledoc """
  Given the input file priv/input_24.txt flip the tiles

  ## Example

  mix lobby_layout
  """

  def run([]) do
    File.stream!("priv/input_24.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> LobbyLayout.place_tiles()
    |> LobbyLayout.count_black_tiles()
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
