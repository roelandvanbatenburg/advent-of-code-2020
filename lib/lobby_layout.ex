defmodule LobbyLayout do
  @moduledoc """
  Replace the floor
  """

  @spec place_tiles(list(String.t())) :: map()
  def place_tiles(directions) do
    Enum.reduce(directions, %{}, &place_tile/2)
  end

  def count_black_tiles(tiles) do
    Enum.count(tiles, fn {_location, color} -> color == :black end)
  end

  defp place_tile(direction, tiles) do
    location = follow_direction(direction)

    case Map.get(tiles, location) do
      :black -> Map.put(tiles, location, :white)
      _ -> Map.put(tiles, location, :black)
    end
  end

  defp follow_direction(direction) do
    direction
    |> step()
  end

  defp step(direction, index \\ 0, location = {y, x} \\ {0, 0}) do
    if index == String.length(direction) do
      location
    else
      case String.at(direction, index) do
        "e" ->
          step(direction, index + 1, {y, x + 1})

        "w" ->
          step(direction, index + 1, {y, x - 1})

        north_or_south ->
          step_y(direction, index, location, north_or_south)
      end
    end
  end

  defp step_y(direction, index, {y, x}, "n") do
    case String.at(direction, index + 1) do
      "e" -> step(direction, index + 2, {y + 0.5, x + 0.5})
      "w" -> step(direction, index + 2, {y + 0.5, x - 0.5})
    end
  end

  defp step_y(direction, index, {y, x}, "s") do
    case String.at(direction, index + 1) do
      "e" -> step(direction, index + 2, {y - 0.5, x + 0.5})
      "w" -> step(direction, index + 2, {y - 0.5, x - 0.5})
    end
  end
end
