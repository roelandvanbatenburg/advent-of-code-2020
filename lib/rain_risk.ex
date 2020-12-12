defmodule RainRisk do
  @moduledoc """
  Steer the boat
  """

  @spec follow_instructions(list(String.t())) :: {integer, integer, integer}
  def follow_instructions(input) do
    input
    |> Enum.reduce({0, 0, 90}, fn line, position -> follow_instruction(line, position) end)
  end

  @spec manhattan_distance({integer, integer, integer}) :: integer
  def manhattan_distance({x, y, _orientation}) do
    abs(x) + abs(y)
  end

  defp follow_instruction(<<action::binary-size(1), value::binary()>>, position) do
    follow_instruction(action, String.to_integer(value), position)
  end

  defp follow_instruction("N", v, {y, x, orientation}), do: {y + v, x, orientation}
  defp follow_instruction("S", v, {y, x, orientation}), do: {y - v, x, orientation}
  defp follow_instruction("E", v, {y, x, orientation}), do: {y, x + v, orientation}
  defp follow_instruction("W", v, {y, x, orientation}), do: {y, x - v, orientation}

  defp follow_instruction("L", v, {y, x, orientation}),
    do: {y, x, normalize_orientation(orientation - v)}

  defp follow_instruction("R", v, {y, x, orientation}),
    do: {y, x, normalize_orientation(orientation + v)}

  defp follow_instruction("F", v, {y, x, 0}), do: {y + v, x, 0}
  defp follow_instruction("F", v, {y, x, 90}), do: {y, x + v, 90}
  defp follow_instruction("F", v, {y, x, 180}), do: {y - v, x, 180}
  defp follow_instruction("F", v, {y, x, 270}), do: {y, x - v, 270}

  defp normalize_orientation(orientation) do
    if orientation < 0 do
      orientation + 360
    else
      if orientation < 360 do
        orientation
      else
        orientation - 360
      end
    end
  end
end
