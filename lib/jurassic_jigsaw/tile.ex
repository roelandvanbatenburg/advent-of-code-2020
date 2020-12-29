defmodule JurassicJigsaw.Tile do
  @moduledoc """
  Tiles with operations
  """
  def parse_tile(<<"Tile ", n::binary-4, ":\n", tile::binary>>) do
    tile = tile |> String.split("\n") |> Enum.map(&String.graphemes/1)
    {String.to_integer(n), tile}
  end

  def orientations(tile), do: rotations(tile) ++ rotations(flip(tile))
  defp rotations(tile), do: tile |> Stream.iterate(&rot/1) |> Enum.take(4)

  def edges(tile), do: [top(tile), bottom(tile), left(tile), right(tile)]

  def all_edges(tile) do
    edges = edges(tile)
    edges ++ Enum.map(edges, &Enum.reverse/1)
  end

  def top(tile), do: tile |> hd()
  def bottom(tile), do: tile |> List.last()
  def left(tile), do: tile |> Enum.map(&hd/1)
  def right(tile), do: tile |> Enum.map(&List.last/1)

  defp flip(tile), do: Enum.reverse(tile)

  defp rot(tile) do
    tile
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.reverse/1)
  end
end
