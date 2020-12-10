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
    ([0 | input] ++ [device_jolt])
    |> Enum.sort()
    |> to_sequence_sizes()
    |> to_weights()
    |> to_solution_count()
  end

  defp to_sequence_sizes(adapters) do
    {sequence_sizes, _} =
      1..length(adapters)
      |> Enum.reduce({[0], 1}, fn index, {sequence_sizes, current_size} ->
        cur = Enum.at(adapters, index)
        prv = Enum.at(adapters, index - 1)

        if cur == prv + 1 do
          {sequence_sizes, current_size + 1}
        else
          {[current_size | sequence_sizes], 1}
        end
      end)

    sequence_sizes
  end

  defp to_weights(sequence_sizes) do
    sequence_sizes
    |> Enum.filter(fn size -> size > 2 end)
    |> Enum.map(fn size ->
      options = size - 2

      if options == 1 do
        2
      else
        (1 + 3 * :math.pow(2, options - 2)) |> round
      end
    end)
  end

  defp to_solution_count(weights) do
    weights
    |> Enum.reduce(fn weight, acc -> weight * acc end)
  end
end
