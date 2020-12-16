defmodule TobogganTrajectory.Grid do
  @moduledoc """
  Handling the grid
  """

  @type grid :: list(list(:tree | :blank))

  @spec parse(list(list(String.t()))) :: grid
  def parse(raw_grid) do
    raw_grid
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(raw_line) do
    raw_line
    |> String.graphemes()
    |> Enum.map(&parse_token/1)
  end

  defp parse_token("."), do: :blank
  defp parse_token("#"), do: :tree

  @spec double(grid, integer) :: grid
  def double(grid, x) do
    width = length(List.first(grid))

    if width < x do
      grid
      |> Enum.map(fn line -> Enum.concat(line, line) end)
    else
      grid
    end
  end

  @spec tree?(grid, [integer | integer]) :: boolean
  def tree?(grid, [x, y]) do
    :tree ==
      grid
      |> Enum.at(y)
      |> Enum.at(x)
  end
end
