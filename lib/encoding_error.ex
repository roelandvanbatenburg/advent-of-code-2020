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

  defp is_valid?(target, preamble) do
    preamble
    |> Enum.any?(&is_valid?(&1, target, preamble))
  end

  defp is_valid?(given, target, preamble) do
    preamble
    |> Enum.any?(fn element -> element != given && target == given + element end)
  end
end
