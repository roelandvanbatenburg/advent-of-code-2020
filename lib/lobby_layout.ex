defmodule LobbyLayout do
  @moduledoc """
  Replace the floor
  """

  @spec place_tiles(list(String.t())) :: map()
  def place_tiles(directions) do
    Enum.reduce(directions, %{}, &place_tile/2)
  end

  def flip(tiles, days \\ 100)
  def flip(tiles, 0), do: tiles

  def flip(tiles, days) do
    tiles
    |> get_relevant_tiles()
    |> Enum.reduce(%{}, fn tile, acc ->
      case next_state(tile, tiles) do
        :black -> Map.put(acc, tile, :black)
        _ -> acc
      end
    end)
    |> flip(days - 1)
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
          step(direction, index + 1, {y, x + 2})

        "w" ->
          step(direction, index + 1, {y, x - 2})

        north_or_south ->
          step_y(direction, index, location, north_or_south)
      end
    end
  end

  defp step_y(direction, index, {y, x}, "n") do
    case String.at(direction, index + 1) do
      "e" -> step(direction, index + 2, {y + 1, x + 1})
      "w" -> step(direction, index + 2, {y + 1, x - 1})
    end
  end

  defp step_y(direction, index, {y, x}, "s") do
    case String.at(direction, index + 1) do
      "e" -> step(direction, index + 2, {y - 1, x + 1})
      "w" -> step(direction, index + 2, {y - 1, x - 1})
    end
  end

  defp get_relevant_tiles(tiles) do
    {y_min, y_max, x_min, x_max} =
      tiles
      |> Map.keys()
      |> Enum.reduce({0, 0, 0, 0}, fn {y, x}, {y_min, y_max, x_min, x_max} ->
        {min(y, y_min), max(y, y_max), min(x, x_min), max(x, x_max)}
      end)

    possible_locations =
      for y <- (y_min - 1)..(y_max + 1), x <- (x_min - 2)..(x_max + 2), do: {y, x}

    possible_locations
    |> Enum.filter(fn {y, x} -> rem(y + x, 2) == 0 end)
  end

  defp next(:black, 1), do: :black
  defp next(_, 2), do: :black
  defp next(:black, _), do: :white
  defp next(_, _), do: :white

  defp next_state(tile, state), do: next(Map.get(state, tile), adjacent_black(tile, state))

  defp adjacent_black(location, state) do
    location
    |> adjacent_tiles()
    |> Enum.count(fn tile -> Map.get(state, tile) == :black end)
  end

  defp adjacent_tiles({y, x}) do
    [{y, x + 2}, {y, x - 2}, {y + 1, x + 1}, {y + 1, x - 1}, {y - 1, x + 1}, {y - 1, x - 1}]
  end
end
