defmodule TobogganTrajectory do
  @moduledoc """
  Find the number of trees encountered
  """

  alias TobogganTrajectory.Grid

  def run(raw_grid, slope \\ [3, 1]) do
    raw_grid
    |> Grid.parse()
    |> step(slope)
  end

  @spec step(Grid.grid(), [integer | integer], [integer | integer], integer) :: integer
  defp step(grid, slope, position \\ [0, 0], trees \\ 0)

  defp step(grid, [slope_x, slope_y] = slope, [x, y], trees) do
    height = length(grid)
    # we reached the end
    if y + slope_y >= height do
      trees
    else
      # double if we need to explore more
      grid = Grid.double(grid, x + slope_x)

      new_position = [x + slope_x, y + slope_y]

      if Grid.tree?(grid, new_position) do
        step(grid, slope, new_position, trees + 1)
      else
        step(grid, slope, new_position, trees)
      end
    end
  end
end
