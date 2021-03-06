defmodule AllergenAssessment do
  @moduledoc """
  Find the food
  """

  @spec parse(list(String.t())) ::
          {list({list(String.t()), list(String.t())}), list(String.t()), list(String.t())}
  def parse(input) do
    food_info =
      input
      |> Enum.map(&parse_line/1)

    {food_info, list_ingredients(food_info), list_allergens(food_info)}
  end

  defp parse_line(input) do
    [ingredients_input, allergens_input] = String.split(input, " (contains ")

    allergens =
      allergens_input
      |> String.trim(")")
      |> String.split(", ")

    ingredients = String.split(ingredients_input)
    {ingredients, allergens}
  end

  defp list_allergens(food_info) do
    food_info
    |> Enum.flat_map(fn {_ingredients, allergens} -> allergens end)
    |> Enum.uniq()
  end

  defp list_ingredients(food_info) do
    food_info
    |> Enum.flat_map(fn {ingredients, _allergens} -> ingredients end)
    |> Enum.uniq()
  end

  @spec map_allergens(list({list(String.t()), list(String.t())}), list(String.t())) :: map
  def map_allergens(food_info, allergens) do
    allergens
    |> Enum.map(&translate(&1, food_info))
    |> Map.new()
  end

  defp translate(allergen, food_info) do
    ingredient =
      Enum.reduce(food_info, [], fn {ingredients, allergens}, candidates ->
        if Enum.member?(allergens, allergen) do
          [MapSet.new(ingredients) | candidates]
        else
          candidates
        end
      end)
      |> Enum.reduce(fn candidate, acc -> MapSet.intersection(acc, candidate) end)

    {allergen, MapSet.to_list(ingredient)}
  end

  defmodule PartOne do
    @moduledoc """
    First puzzle
    """

    def count_non_allergen_ingredients({food_info, _ingredients, allergens}) do
      allergen_ingredients =
        AllergenAssessment.map_allergens(food_info, allergens)
        |> Map.values()
        |> List.flatten()
        |> Enum.uniq()

      food_info
      |> Enum.reduce(0, fn {ingredients, _allergens}, acc ->
        acc +
          length(
            Enum.filter(ingredients, fn ingredient ->
              !Enum.member?(allergen_ingredients, ingredient)
            end)
          )
      end)
    end
  end

  defmodule PartTwo do
    @moduledoc """
    Second puzzle
    """

    def canonical_dangerous_ingredient_list({food_info, _ingredients, allergens}) do
      AllergenAssessment.map_allergens(food_info, allergens)
      |> solve()
    end

    defp solve(mapping) do
      if solved?(mapping) do
        mapping
        |> Enum.to_list()
        |> Enum.sort(fn {allergen_a, _}, {allergen_b, _} -> allergen_a < allergen_b end)
        |> Enum.map(fn {_allergen, ingredient} -> List.last(ingredient) end)
        |> Enum.join(",")
      else
        # only one ingredient per mapping
        mapped_ingredients =
          mapping
          |> Enum.filter(fn {_allergen, ingredient} -> length(ingredient) == 1 end)
          |> Enum.reduce([], fn {_allergen, ingredient}, acc -> [List.first(ingredient) | acc] end)

        mapping
        |> Enum.map(&filter_when_necessary(&1, mapped_ingredients))
        |> solve()
      end
    end

    defp solved?(mapping) do
      mapping
      |> Enum.all?(fn {_allergen, ingredient} -> length(ingredient) == 1 end)
    end

    defp filter_when_necessary({allergen, ingredient} = original, mapped_ingredients) do
      if length(ingredient) == 1 do
        original
      else
        {allergen, Enum.filter(ingredient, fn i -> !Enum.member?(mapped_ingredients, i) end)}
      end
    end
  end
end
