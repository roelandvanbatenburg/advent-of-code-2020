defmodule JurassicJigsaw do
  @moduledoc """
  Look for the beast
  """

  alias JurassicJigsaw.Tile

  @spec parse(String.t()) :: list(Tile.t())
  def parse(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&parse_tile/1)
  end

  defp parse_tile(input) do
    [id_line | tile_input] = String.split(input, "\n")
    Tile.create(id_line, tile_input)
  end

  def position_and_id(placed_tiles) do
    placed_tiles
    |> Enum.map(fn {pos, tile} -> {pos, tile.id} end)
  end

  defmodule Tile do
    @moduledoc "tile"
    @enforce_keys [:corners, :id, :tile]
    defstruct @enforce_keys

    # (# or .)
    @type value :: :filled | :empty
    @type line :: list()
    @type t() :: %__MODULE__{
            corners: list(list()),
            tile: list(list()),
            id: integer
          }

    @spec create(String.t(), list(String.t())) :: t()
    def create(id_line, tile) do
      %__MODULE__{
        id: String.to_integer(String.slice(id_line, 5..8)),
        tile: tile,
        corners: get_corners(tile)
      }
    end

    @spec is_corner?(Tile.t(), list(Tile.t())) :: boolean
    def is_corner?(tile, tiles) do
      tiles
      |> Enum.reduce(0, fn target, neighbour_cnt ->
        if target.id == tile.id do
          neighbour_cnt
        else
          if Enum.any?(target.corners, fn corner -> Enum.member?(tile.corners, corner) end) do
            neighbour_cnt + 1
          else
            neighbour_cnt
          end
        end
      end) === 2
    end

    defp get_corners(tile) do
      [
        parse_row(List.first(tile)),
        parse_row(List.last(tile)),
        parse_column(tile, 0),
        parse_column(tile, 9),
        parse_row(List.first(tile)) |> Enum.reverse(),
        parse_row(List.last(tile)) |> Enum.reverse(),
        parse_column(tile, 0) |> Enum.reverse(),
        parse_column(tile, 9) |> Enum.reverse()
      ]
    end

    defp parse_row(line) do
      line
      |> String.split("")
      |> Enum.filter(fn e -> e != "" end)
      |> Enum.map(&parse_token/1)
    end

    defp parse_column(tile, x) do
      tile
      |> Enum.map(&String.at(&1, x))
      |> Enum.map(&parse_token/1)
    end

    defp parse_token("#"), do: :filled
    defp parse_token("."), do: :empty
  end

  defmodule PartOne do
    @moduledoc """
    First puzzle
    """
    @spec find_corners(list(Tile.t())) :: list(Tile.t())
    def find_corners(tiles) do
      tiles
      |> Enum.filter(&Tile.is_corner?(&1, tiles))
    end

    @spec id_product(list(Tile.t())) :: integer
    def id_product(tiles) do
      tiles
      |> Enum.reduce(1, fn tile, acc -> acc * tile.id end)
    end
  end

  defmodule PartTwo do
    @moduledoc """
    Second puzzle
    """

    @spec solve(list(Tile.t())) :: map()
    def solve(tiles) do
      corner_piece = Enum.find(tiles, &Tile.is_corner?(&1, tiles))
      tiles = List.delete(tiles, corner_piece)
      positions = Map.put(%{}, {0, 0}, corner_piece)

      solve(tiles, positions)
    end

    defp solve([], positions), do: positions

    defp solve(tiles, positions) do
      {location, placed_tile, original_tile} =
        Enum.find(tiles, fn tile ->
          case match_orientation(tile, positions) do
            nil -> nil
          end
        end)

      tiles = List.delete(tiles, original_tile)
      positions = Map.put(positions, location, placed_tile)

      solve(tiles, positions)
    end

    defp match_orientation(tile, positions) do
      possible_positions(positions)
      |> Enum.find_value(fn position -> place_tile(position, tile, positions) end)
    end

    defp place_tile(position, tile, _positions) do
      # todo: return {location, rotated/flipped tile, orginal tile} if it matched
      # nil if it doesn't fit here
      {position, tile, tile}
    end

    defp possible_positions(positions) do
      filled = Map.keys(positions)

      # todo: +/- x/y for each
      filled
      |> Enum.flat_map(fn position -> [position] end)
      |> Enum.uniq()
      |> Enum.filter(fn position -> Enum.member?(filled, position) end)
    end
  end
end
