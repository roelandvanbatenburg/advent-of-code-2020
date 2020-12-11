defmodule SeatingSystem do
  @moduledoc """
  Fill the seats
  """

  @spec count_occupied(map()) :: integer
  def count_occupied(area) do
    area
    |> Enum.reduce(0, fn {_key, state}, count -> count + SeatingSystem.is_occupied(state) end)
  end

  def is_occupied(area, y, x) do
    Map.get(area, {y, x})
    |> is_occupied
  end

  def is_occupied(:occupied), do: 1
  def is_occupied(_), do: 0

  @spec parse_to_map(list(String.t())) :: {map(), integer, integer}
  def parse_to_map(input) do
    height = length(input)
    width = String.length(List.first(input))

    area =
      0..(height - 1)
      |> Enum.reduce(%{}, fn y, area ->
        0..(width - 1)
        |> Enum.reduce(area, fn x, area ->
          Map.put(area, {y, x}, Enum.at(input, y) |> String.at(x) |> parse_token())
        end)
      end)

    {area, height, width}
  end

  defp parse_token("L"), do: :empty
  defp parse_token("."), do: :floor

  defmodule PartOne do
    @moduledoc """
    First puzzle
    """

    @spec stabilize({map(), integer, integer}) :: map()
    def stabilize(input) do
      input
      |> step
    end

    defp step({prev_area, height, width}) do
      area =
        0..(height - 1)
        |> Enum.reduce(%{}, fn y, area ->
          0..(width - 1)
          |> Enum.reduce(area, fn x, area ->
            Map.put(
              area,
              {y, x},
              next_state(Map.fetch!(prev_area, {y, x}), prev_area, y, x)
            )
          end)
        end)

      if Map.equal?(prev_area, area) do
        area
      else
        step({area, height, width})
      end
    end

    defp next_state(:floor, _area, _y, _x), do: :floor

    defp next_state(:empty, area, y, x) do
      if adjacent_occupied_seats(area, y, x) == 0 do
        :occupied
      else
        :empty
      end
    end

    defp next_state(:occupied, area, y, x) do
      if adjacent_occupied_seats(area, y, x) >= 4 do
        :empty
      else
        :occupied
      end
    end

    defp adjacent_occupied_seats(area, y, x) do
      is_occupied(area, y - 1, x - 1) + is_occupied(area, y - 1, x) +
        is_occupied(area, y - 1, x + 1) + is_occupied(area, y, x - 1) +
        is_occupied(area, y, x + 1) +
        is_occupied(area, y + 1, x - 1) + is_occupied(area, y + 1, x) +
        is_occupied(area, y + 1, x + 1)
    end

    defdelegate is_occupied(area, y, x), to: SeatingSystem
  end
end
