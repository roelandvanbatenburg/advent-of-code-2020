defmodule TobogganTrajectory do
  @moduledoc """
  Find the number of trees encountered
  """

  alias TobogganTrajectory.Grid

  def run(raw_grid) do
    raw_grid
    |> Grid.parse()
    |> step([0, 0], 0, false)
  end

  @spec step(Grid.grid(), [integer | integer], integer, boolean) :: integer

  defp step(grid, [x, y], trees, false) do
    IO.puts("#{x} #{y} #{trees}")
    height = length(grid)

    # we reached the end
    if y + 1 == height do
      step(grid, [x, y], trees, true)
    else
      # double if we need to explore more
      grid = Grid.double(grid, x + 3)

      new_position = [x + 3, y + 1]

      if Grid.tree?(grid, new_position) do
        step(grid, new_position, trees + 1, false)
      else
        step(grid, new_position, trees, false)
      end
    end
  end

  defp step(_grid, _position, trees, true) do
    trees
  end
end
