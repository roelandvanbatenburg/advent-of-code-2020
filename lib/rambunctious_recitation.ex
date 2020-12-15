defmodule RambunctiousRecitation do
  @moduledoc """
  Elf memory game
  """

  defmodule PartOne do
    @moduledoc """
    First puzzle
    """

    @spec speak(list(any)) :: integer
    def speak(input) do
      {_positions, nmbr} =
        0..(2020 - 1)
        |> Enum.reduce({%{}, nil}, fn index, acc -> step(index, acc, input) end)

      nmbr
    end

    defp step(index, {last_positions, previous}, input) do
      nmbr =
        if index < length(input) do
          Enum.at(input, index)
        else
          case Map.get(last_positions, previous) do
            nil -> 0
            last -> index - last
          end
        end

      {Map.put(last_positions, previous, index), nmbr}
    end
  end

  defmodule PartTwo do
    @moduledoc """
    Second puzzle
    """
  end
end
