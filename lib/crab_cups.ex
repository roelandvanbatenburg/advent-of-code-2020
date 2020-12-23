defmodule CrabCups do
  @moduledoc """
  Play cups with a crab
  """

  @spec step(list(integer), integer) :: list(integer)
  def step(cups, steps \\ 100, current_index \\ 0)
  def step(cups, 0, _current_index), do: cups

  def step(cups, steps, current_index) do
    current_cup = Enum.at(cups, current_index)
    {table, picked_cups} = pick_up_cups(cups, current_index)

    destination_cup_index = find_destination_cup(table, current_cup - 1)

    cups =
      picked_cups
      |> Enum.reverse()
      |> Enum.reduce(table, fn cup, table ->
        List.insert_at(table, destination_cup_index + 1, cup)
      end)

    current_index = Enum.find_index(cups, fn cup -> cup == current_cup end) + 1

    if current_index == length(cups) do
      step(cups, steps - 1, 0)
    else
      step(cups, steps - 1, current_index)
    end
  end

  defp pick_up_cups(cups, from_index) do
    picked_cups =
      case length(cups) - from_index do
        1 -> Enum.slice(cups, 0..2)
        2 -> [List.last(cups)] ++ Enum.slice(cups, 0..1)
        3 -> Enum.slice(cups, -2..-1) ++ [List.first(cups)]
        _ -> Enum.slice(cups, from_index + 1, 3)
      end

    {Enum.filter(cups, fn cup -> !Enum.member?(picked_cups, cup) end), picked_cups}
  end

  defp find_destination_cup(cups, target) do
    if target < Enum.min(cups) do
      find_destination_cup(cups, Enum.max(cups))
    else
      case Enum.find_index(cups, fn cup -> cup == target end) do
        nil -> find_destination_cup(cups, target - 1)
        cup_index -> cup_index
      end
    end
  end

  @spec from_one(list(integer)) :: String.t()
  def from_one(cups) do
    [rest, start] =
      cups
      |> Enum.join()
      |> String.split("1")

    Enum.join([start, rest])
  end
end
