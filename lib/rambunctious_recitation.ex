defmodule RambunctiousRecitation do
  @moduledoc """
  Elf memory game
  """

  @spec speak(list(any), integer) :: integer
  def speak(input, target \\ 2020) do
    {_positions, nmbr} =
      0..(target - 1)
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
