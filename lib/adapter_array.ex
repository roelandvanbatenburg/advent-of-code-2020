defmodule AdapterArray do
  @moduledoc """
  Try different adapters
  """

  @spec use_every_adapter(list(integer)) :: {integer, integer, integer, integer}
  def use_every_adapter(input) do
    device_jolt = Enum.max(input) + 3

    [device_jolt | input]
    |> Enum.sort()
    |> Enum.reduce({0, 0, 0, 0}, fn x, {ones, twos, threes, current} ->
      case x - current do
        1 -> {ones + 1, twos, threes, x}
        2 -> {ones, twos + 1, threes, x}
        3 -> {ones, twos, threes + 1, x}
        _ -> raise "non sequential adapter! #{x} => #{current}"
      end
    end)
  end

  def count_all_solutions(input) do
    device_jolt = Enum.max(input) + 3

    # add 0 as starting point
    [0 | input]
    |> Enum.sort()
    |> count_solutions(0, 0, device_jolt)
  end

  defp count_solutions(adapters, index, previous, target) do
    adapter_cnt = length(adapters)
    current = Enum.at(adapters, index)

    if index >= adapter_cnt || current - previous > 3 do
      # out of range or step too big
      0
    else
      if index == adapter_cnt - 1 do
        if target - current > 3 do
          # no solution found
          0
        else
          1
        end
      else
        if target - current <= 3 do
          # special case where this is a solution, but there might be more
          1
        else
          0
        end

        +count_solutions(adapters, index + 1, current, target) +
          count_solutions(adapters, index + 2, current, target) +
          count_solutions(adapters, index + 3, current, target)
      end
    end
  end
end
