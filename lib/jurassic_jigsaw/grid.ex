defmodule JurassicJigsaw.Grid do
  alias JurassicJigsaw.Tile

  @moduledoc """
  Grid of Tiles
  """

  def build_grid(tiles) do
    [{id, tile, edges} | tiles] =
      Enum.map(tiles, fn {id, tile} -> {id, tile, Tile.all_edges(tile)} end)

    edges = edges |> Enum.take(4) |> edge_entry({0, 0})

    build_grid(%{{0, 0} => {id, tile}}, edges, tiles)
  end

  defp build_grid(grid, _, []), do: grid

  defp build_grid(grid, free_edges, [tile = {_, _, edges} | tiles]) do
    if edge = Enum.find(edges, &Map.has_key?(free_edges, &1)) do
      {grid, free_edges} = place(grid, free_edges, tile, Map.get(free_edges, edge), edge)
      build_grid(grid, free_edges, tiles)
    else
      build_grid(grid, free_edges, tiles ++ [tile])
    end
  end

  defp place(g, f, t, {{x, y}, :top}, e), do: place(g, f, &Tile.bottom/1, {x, y + 1}, t, e)
  defp place(g, f, t, {{x, y}, :bottom}, e), do: place(g, f, &Tile.top/1, {x, y - 1}, t, e)
  defp place(g, f, t, {{x, y}, :left}, e), do: place(g, f, &Tile.right/1, {x - 1, y}, t, e)
  defp place(g, f, t, {{x, y}, :right}, e), do: place(g, f, &Tile.left/1, {x + 1, y}, t, e)

  defp place(grid, free, dir, {x, y}, {id, tile, _}, edge) do
    tile = adjust(tile, &(dir.(&1) == edge))
    grid = Map.put(grid, {x, y}, {id, tile})
    free = tile |> Tile.edges() |> edge_entry({x, y}) |> Map.merge(free)

    {grid, free}
  end

  defp fit?(tile, fun), do: fun.(tile)
  defp adjust(tile, fun), do: tile |> Tile.orientations() |> Enum.find(&fit?(&1, fun))

  def edge_entry(edges, {x, y}) do
    edges
    |> Enum.zip([:top, :bottom, :left, :right] |> Enum.map(&{{x, y}, &1}))
    |> Map.new()
  end
end
