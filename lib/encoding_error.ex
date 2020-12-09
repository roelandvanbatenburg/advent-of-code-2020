defmodule EncodingError do
  @moduledoc """
  Decode XMAS
  """

  @spec find_first_non_valid(list(integer), integer) :: integer
  def find_first_non_valid(input, preamble_size \\ 25) do
    case preamble_size..(length(input) - 1)
         |> Enum.find(fn index ->
           !is_valid?(Enum.at(input, index), Enum.slice(input, (index - preamble_size)..index))
         end) do
      nil -> nil
      index -> Enum.at(input, index)
    end
  end

  @spec find_contiguous_set(integer, list(integer)) :: [integer | integer]
  def find_contiguous_set(target, input) do
    0..(length(input) - 1)
    |> Enum.find_value(&find_contiguous_set(&1, input, target))
  end

  defp is_valid?(target, preamble) do
    preamble
    |> Enum.any?(&is_valid?(&1, target, preamble))
  end

  defp is_valid?(given, target, preamble) do
    preamble
    |> Enum.any?(fn element -> element != given && target == given + element end)
  end

  defp find_contiguous_set(start, input, target) do
    2..(length(input) - start - 1)
    |> Enum.find_value(&get_min_max(&1, start, input, target))
  end

  defp get_min_max(size, start, input, target) do
    # IO.puts("inspecting #{start}..#{start + size}")
    set = Enum.slice(input, start..(start + size))

    if Enum.sum(set) == target do
      [Enum.min(set), Enum.max(set)]
    else
      nil
    end
  end
end
