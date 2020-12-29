defmodule CrabCups do
  @moduledoc """
  Play cups with a crab
  """

  # @numberof_cups 10
  @number_of_cups 1_000_000

  @spec init_lookup(list(integer)) :: {map(), integer}
  def init_lookup(cups) do
    lookup =
      0..@number_of_cups
      |> Enum.reduce(%{}, fn i, lookup ->
        if i < length(cups) - 1 do
          Map.put(lookup, Enum.at(cups, i), Enum.at(cups, i + 1))
        else
          if i == length(cups) - 1 do
            Map.put(lookup, List.last(cups), Enum.max(cups) + 1)
          else
            Map.put(lookup, i + 1, i + 2)
          end
        end
      end)

    {Map.put(lookup, @number_of_cups, List.first(cups)), List.first(cups)}
  end

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
    cup_size = length(cups)

    picked_indices =
      case length(cups) - from_index do
        1 -> [0, 0, 0]
        2 -> [cup_size - 1, 0, 0]
        3 -> [cup_size - 2, cup_size - 2, 0]
        _ -> [from_index + 1, from_index + 1, from_index + 1]
      end

    picked_indices
    |> Enum.reduce({cups, []}, fn i, {table, picked_cups} ->
      {List.delete_at(table, i), picked_cups ++ [Enum.at(table, i)]}
    end)
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

  def step_with_lookup(state, steps \\ 10_000_000)

  def step_with_lookup({lookup, _}, 0),
    do: Map.get(lookup, 1) * Map.get(lookup, Map.get(lookup, 1))

  def step_with_lookup({lookup, current_cup}, steps) do
    cup1 = Map.get(lookup, current_cup)
    cup2 = Map.get(lookup, cup1)
    cup3 = Map.get(lookup, cup2)

    lookup = Map.put(lookup, current_cup, Map.get(lookup, cup3))

    destination_cup = determine_destination_cup(current_cup, [cup1, cup2, cup3])

    lookup = Map.put(lookup, cup3, Map.get(lookup, destination_cup))
    lookup = Map.put(lookup, destination_cup, cup1)

    next_cup = Map.get(lookup, current_cup)

    step_with_lookup({lookup, next_cup}, steps - 1)
  end

  defp determine_destination_cup(current_cup, picked_cups) do
    if current_cup == 1 do
      @number_of_cups
    else
      current_cup - 1
    end
    |> find_valid_destination_cup(picked_cups)
  end

  defp find_valid_destination_cup(destination_cup, picked_cups) do
    if Enum.member?(picked_cups, destination_cup) do
      determine_destination_cup(destination_cup, picked_cups)
    else
      destination_cup
    end
  end
end
