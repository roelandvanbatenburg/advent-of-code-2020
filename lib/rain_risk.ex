defmodule RainRisk do
  @moduledoc """
  Steer the ferry
  """

  @spec manhattan_distance({integer, integer}) :: integer
  def manhattan_distance({x, y}) do
    abs(x) + abs(y)
  end

  defmodule PartOne do
    @moduledoc """
    First puzzle
    """

    @spec follow_instructions(list(String.t())) :: {integer, integer}
    def follow_instructions(input) do
      {y, x, _orientation} =
        input
        |> Enum.reduce({0, 0, 90}, fn line, position -> follow_instruction(line, position) end)

      {y, x}
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

  defmodule PartTwo do
    @moduledoc """
    Second puzzle
    """

    @spec follow_instructions(list(String.t())) :: {integer, integer}
    def follow_instructions(input) do
      {ferry, _waypoint} =
        input
        |> Enum.reduce({{0, 0}, {1, 10}}, fn line, acc -> follow_instruction(line, acc) end)

      ferry
    end

    defp follow_instruction(<<action::binary-size(1), value::binary()>>, positions) do
      follow_instruction(action, String.to_integer(value), positions)
    end

    defp follow_instruction("N", v, {ferry, {w_y, w_x}}), do: {ferry, {w_y + v, w_x}}
    defp follow_instruction("S", v, {ferry, {w_y, w_x}}), do: {ferry, {w_y - v, w_x}}
    defp follow_instruction("E", v, {ferry, {w_y, w_x}}), do: {ferry, {w_y, w_x + v}}
    defp follow_instruction("W", v, {ferry, {w_y, w_x}}), do: {ferry, {w_y, w_x - v}}

    defp follow_instruction("F", v, {{y, x}, {w_y, w_x} = waypoint}),
      do: {{y + v * w_y, x + v * w_x}, waypoint}

    defp follow_instruction("R", 90, {ferry, {w_y, w_x}}), do: {ferry, {-w_x, w_y}}
    defp follow_instruction("R", 180, {ferry, {w_y, w_x}}), do: {ferry, {-w_y, -w_x}}
    defp follow_instruction("R", 270, {ferry, {w_y, w_x}}), do: {ferry, {w_x, -w_y}}

    defp follow_instruction("L", 270, {ferry, {w_y, w_x}}), do: {ferry, {-w_x, w_y}}
    defp follow_instruction("L", 180, {ferry, {w_y, w_x}}), do: {ferry, {-w_y, -w_x}}
    defp follow_instruction("L", 90, {ferry, {w_y, w_x}}), do: {ferry, {w_x, -w_y}}
  end
end
