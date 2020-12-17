defmodule ConwayCubes do
  # credo:disable-for-this-file Credo.Check.Refactor.Nesting
  @moduledoc """
  Help the elves
  """

  @type position :: {x :: integer, y :: integer, z :: integer, w :: integer}
  @type grid_dimensions ::
          {{x_min :: integer, x_max :: integer}, {y_min :: integer, y_max :: integer},
           {z_min :: integer, z_max :: integer}, {w_min :: integer, w_max :: integer}}
  @type active_cubes_info ::
          {active_cubes :: %{required(position) => :active}, grid_dimensions :: grid_dimensions}

  @spec parse(list(String.t())) :: active_cubes_info
  def parse(input) do
    y_max = length(input)
    x_max = String.length(List.first(input))

    active_cubes =
      0..(y_max - 1)
      |> Enum.reduce(%{}, fn y, active_cubes ->
        0..(x_max - 1)
        |> Enum.reduce(active_cubes, fn x, acc ->
          case input |> Enum.at(y) |> String.at(x) do
            "." -> acc
            "#" -> Map.put(acc, {x, y, 0, 0}, :active)
          end
        end)
      end)

    {active_cubes, {{0, x_max - 1}, {0, y_max - 1}, {0, 0}, {0, 0}}}
  end

  def active({active_cubes, _}) do
    map_size(active_cubes)
  end

  defmodule PartOne do
    @moduledoc """
    First puzzle
    """

    @spec step(ConwayCubes.active_cubes_info(), steps :: integer) ::
            ConwayCubes.active_cubes_info()
    def step(result, 0), do: result

    def step({prev_active_cubes, prev_grid_dimensions}, steps) do
      grid_dimensions = next_grid_dimensions(prev_grid_dimensions)
      {{x_min, x_max}, {y_min, y_max}, {z_min, z_max}, _w} = grid_dimensions

      active_cubes =
        z_min..z_max
        |> Enum.reduce(%{}, fn z, active_cubes ->
          y_min..y_max
          |> Enum.reduce(active_cubes, fn y, active_cubes ->
            x_min..x_max
            |> Enum.reduce(active_cubes, fn x, active_cubes ->
              determine_state({x, y, z, 0}, active_cubes, prev_active_cubes)
            end)
          end)
        end)

      {active_cubes, grid_dimensions}
      |> step(steps - 1)
    end

    defp determine_state(position, active_cubes, prev_active_cubes) do
      active_neighbours =
        get_neighbours(position)
        |> count_active_neighbours(prev_active_cubes)

      if Map.has_key?(prev_active_cubes, position) do
        if active_neighbours == 2 || active_neighbours == 3 do
          Map.put(active_cubes, position, :active)
        else
          active_cubes
        end
      else
        if active_neighbours == 3 do
          Map.put(active_cubes, position, :active)
        else
          active_cubes
        end
      end
    end

    defp get_neighbours({x, y, z, _w}) do
      (z - 1)..(z + 1)
      |> Enum.reduce([], fn z, neighbours ->
        (y - 1)..(y + 1)
        |> Enum.reduce(neighbours, fn y, neighbours ->
          (x - 1)..(x + 1)
          |> Enum.reduce(neighbours, fn x, neighbours ->
            [{x, y, z, 0} | neighbours]
          end)
        end)
      end)
      |> List.delete({x, y, z, 0})
    end

    defp count_active_neighbours(neighbours, prev_active_cubes) do
      neighbours
      |> Enum.reduce(0, fn neighbour, acc ->
        case Map.has_key?(prev_active_cubes, neighbour) do
          true -> acc + 1
          false -> acc
        end
      end)
    end

    defp next_grid_dimensions({x, y, z, w}) do
      {next_grid_dimensions(x), next_grid_dimensions(y), next_grid_dimensions(z), w}
    end

    defp next_grid_dimensions({min, max}), do: {min - 1, max + 1}
  end

  defmodule PartTwo do
    @moduledoc """
    Second puzzle
    """

    @spec step(ConwayCubes.active_cubes_info(), steps :: integer) ::
            ConwayCubes.active_cubes_info()
    def step(result, 0), do: result

    def step({prev_active_cubes, prev_grid_dimensions}, steps) do
      grid_dimensions = next_grid_dimensions(prev_grid_dimensions)
      {{x_min, x_max}, {y_min, y_max}, {z_min, z_max}, {w_min, w_max}} = grid_dimensions

      active_cubes =
        z_min..z_max
        |> Enum.reduce(%{}, fn z, active_cubes ->
          y_min..y_max
          |> Enum.reduce(active_cubes, fn y, active_cubes ->
            x_min..x_max
            |> Enum.reduce(active_cubes, fn x, active_cubes ->
              w_min..w_max
              |> Enum.reduce(active_cubes, fn w, active_cubes ->
                determine_state({x, y, z, w}, active_cubes, prev_active_cubes)
              end)
            end)
          end)
        end)

      {active_cubes, grid_dimensions}
      |> step(steps - 1)
    end

    defp determine_state(position, active_cubes, prev_active_cubes) do
      active_neighbours =
        get_neighbours(position)
        |> count_active_neighbours(prev_active_cubes)

      if Map.has_key?(prev_active_cubes, position) do
        if active_neighbours == 2 || active_neighbours == 3 do
          Map.put(active_cubes, position, :active)
        else
          active_cubes
        end
      else
        if active_neighbours == 3 do
          Map.put(active_cubes, position, :active)
        else
          active_cubes
        end
      end
    end

    defp get_neighbours({x, y, z, w}) do
      (z - 1)..(z + 1)
      |> Enum.reduce([], fn z, neighbours ->
        (y - 1)..(y + 1)
        |> Enum.reduce(neighbours, fn y, neighbours ->
          (x - 1)..(x + 1)
          |> Enum.reduce(neighbours, fn x, neighbours ->
            (w - 1)..(w + 1)
            |> Enum.reduce(neighbours, fn w, neighbours ->
              [{x, y, z, w} | neighbours]
            end)
          end)
        end)
      end)
      |> List.delete({x, y, z, w})
    end

    defp count_active_neighbours(neighbours, prev_active_cubes) do
      neighbours
      |> Enum.reduce(0, fn neighbour, acc ->
        case Map.has_key?(prev_active_cubes, neighbour) do
          true -> acc + 1
          false -> acc
        end
      end)
    end

    defp next_grid_dimensions({x, y, z, w}) do
      {next_grid_dimensions(x), next_grid_dimensions(y), next_grid_dimensions(z),
       next_grid_dimensions(w)}
    end

    defp next_grid_dimensions({min, max}), do: {min - 1, max + 1}
  end
end
