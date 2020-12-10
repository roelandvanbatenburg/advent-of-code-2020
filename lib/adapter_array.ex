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
end
