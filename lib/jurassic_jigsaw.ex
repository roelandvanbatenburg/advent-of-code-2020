defmodule JurassicJigsaw do
  @moduledoc """
  Look for the beast
  """

  alias JurassicJigsaw.Tile

  def parse(input) do
    input
    |> String.trim()
    |> String.split("\n\n")
    |> Enum.map(&Tile.parse_tile/1)
    |> Map.new()
  end

  defmodule PartOne do
    @moduledoc """
    First puzzle
    """
    def multiply_corners(grid) do
      {{min_x, _}, {max_x, _}} = grid |> Map.keys() |> Enum.min_max_by(&elem(&1, 0))
      {{_, min_y}, {_, max_y}} = grid |> Map.keys() |> Enum.min_max_by(&elem(&1, 1))

      [{min_x, min_y}, {min_x, max_y}, {max_x, min_y}, {max_x, max_y}]
      |> Enum.map(&Map.fetch!(grid, &1))
      |> Enum.map(&elem(&1, 0))
      |> Enum.reduce(1, &(&1 * &2))
    end
  end

  defmodule PartTwo do
    @moduledoc """
    Second puzzle
    """

    @monster_size 15
    @monster [~r/..................#./, ~r/#....##....##....###/, ~r/.#..#..#..#..#..#.../]

    def roughness(grid) do
      grid
      |> to_picture()
      |> Enum.map(&Enum.join/1)
      |> Enum.join("\n")
      |> find_all()
      |> count_without_monsters()
    end

    defp count_without_monsters({str, monsters}) do
      monsters = length(monsters)
      pounds = str |> String.graphemes() |> Enum.count(&(&1 == "#"))
      pounds - monsters * @monster_size
    end

    defp find_all(str) do
      str
      |> to_list()
      |> Tile.orientations()
      |> Enum.map(&to_text/1)
      |> Enum.map(&{&1, find(&1)})
      |> Enum.filter(&(elem(&1, 1) != []))
      |> hd()
    end

    defp find(str) do
      str
      |> String.split("\n")
      |> Enum.chunk_every(3, 1, :discard)
      |> Enum.filter(fn s ->
        s
        |> Enum.zip(@monster)
        |> Enum.map(fn {s, r} -> Regex.match?(r, s) end)
        |> Enum.all?()
      end)
    end

    defp to_list(str), do: str |> String.split("\n") |> Enum.map(&String.graphemes/1)
    defp to_text(lst), do: lst |> Enum.map(&Enum.join/1) |> Enum.join("\n")

    defp to_picture(grid) do
      grid
      |> Enum.map(fn {k, {_, v}} -> {k, v} end)
      |> Enum.map(&drop_edges/1)
      |> Enum.group_by(fn {{_, y}, _} -> y end)
      |> Enum.map(&join_row/1)
      |> Enum.sort_by(fn {k, _} -> k end, :desc)
      |> Enum.map(&elem(&1, 1))
      |> Enum.concat()
    end

    defp drop_edges({k, v}), do: {k, drop_edges(v)}

    defp drop_edges(tile) when is_list(tile) do
      tile |> tl() |> List.delete_at(-1) |> Enum.map(&(&1 |> tl() |> List.delete_at(-1)))
    end

    defp join_row({k, lst}) do
      v =
        lst
        |> Enum.sort_by(fn {{x, _}, _} -> x end)
        |> Enum.map(fn {_, tile} -> tile end)
        |> join_row()

      {k, v}
    end

    defp join_row(tiles) do
      tiles |> Enum.zip() |> Enum.map(&Tuple.to_list/1) |> Enum.map(&Enum.concat/1)
    end
  end
end
