defmodule ReportRepair do
  @moduledoc """
  Find the two or three numbers in the list that add to 2020 and return the product
  """

  @spec run2(list(integer)) :: integer
  def run2(list) do
    list
    |> Enum.find_value(fn element -> find_2020(element, element, list) end)
  end

  @spec run3(list(integer)) :: integer
  def run3(list) do
    list
    |> Enum.find_value(fn element -> find_2020_in_2(element, list) end)
  end

  defp find_2020_in_2(first_element, list) do
    case list
         |> Enum.find_value(fn element -> find_2020(first_element + element, element, list) end) do
      nil -> nil
      product -> first_element * product
    end
  end

  defp find_2020(sum_so_far, element, list) do
    case find_match_2020(sum_so_far, list) do
      nil -> nil
      second_element -> element * second_element
    end
  end

  defp find_match_2020(first_element, list) do
    list
    |> Enum.find_value(fn element ->
      if is_2020?(first_element, element) do
        element
      else
        false
      end
    end)
  end

  defp is_2020?(first_element, second_element), do: first_element + second_element == 2020
end
