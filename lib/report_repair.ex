defmodule ReportRepair do
  @moduledoc """
  Find the two numbers in the list that add to 2020 and return the product
  """

  @spec run(list(integer)) :: integer
  def run(list) do
    list
    |> Enum.find_value(fn element -> find_2020(element, list) end)
  end

  defp find_2020(element, list) do
    case find_match_2020(element, list) do
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
