defmodule DockingData do
  @moduledoc """
  Dock the ferry
  """

  defmodule PartOne do
    @moduledoc """
    First puzzle
    """

    @spec follow_program(list(String.t())) :: map()
    def follow_program(input) do
      {_mask, memory} =
        input
        |> Enum.reduce({"", %{}}, &follow_line/2)

      memory
    end

    @spec sum(map()) :: integer
    def sum(memory) do
      memory
      |> Map.values()
      |> Enum.sum()
    end

    defp follow_line(line, acc) do
      line
      |> String.split(" = ")
      |> apply_line(acc)
    end

    defp apply_line(["mask", mask], {_prev_mask, memory}), do: {mask, memory}

    defp apply_line([raw_mem, value], {mask, memory}) do
      [_, position] = Regex.run(~r/mem\[(\d+)\]/, raw_mem)
      {mask, Map.put(memory, position, get_value(mask, value))}
    end

    defp get_value(mask, value) do
      value
      |> String.to_integer()
      |> Integer.to_string(2)
      |> String.pad_leading(36, "0")
      |> apply_mask(mask)
      |> String.to_integer(2)
    end

    defp apply_mask(value, mask) do
      0..(String.length(value) - 1)
      |> Enum.reduce("", fn index, acc ->
        acc <> get_masked_value(String.at(mask, index), String.at(value, index))
      end)
    end

    defp get_masked_value("X", value), do: value
    defp get_masked_value(mask, _), do: mask
  end
end
