defmodule AllergenAssessmentTest do
  use ExUnit.Case

  alias AllergenAssessment.{PartOne, PartTwo}

  setup _context do
    {:ok,
     input: [
       "mxmxvkd kfcds sqjhc nhms (contains dairy, fish)",
       "trh fvjkl sbzzf mxmxvkd (contains dairy)",
       "sqjhc fvjkl (contains soy)",
       "sqjhc mxmxvkd sbzzf (contains fish)"
     ]}
  end

  test "find non allergen ingredients", %{input: input} do
    parsed_input = AllergenAssessment.parse(input)
    {food_info, ingredients, allergens} = parsed_input
    assert ingredients == ["mxmxvkd", "kfcds", "sqjhc", "nhms", "trh", "fvjkl", "sbzzf"]
    assert allergens == ["dairy", "fish", "soy"]

    assert food_info == [
             {["mxmxvkd", "kfcds", "sqjhc", "nhms"], ["dairy", "fish"]},
             {["trh", "fvjkl", "sbzzf", "mxmxvkd"], ["dairy"]},
             {["sqjhc", "fvjkl"], ["soy"]},
             {["sqjhc", "mxmxvkd", "sbzzf"], ["fish"]}
           ]

    assert 5 == PartOne.count_non_allergen_ingredients(parsed_input)
  end

  test "list allergen ingredients", %{input: input} do
    assert "mxmxvkd,sqjhc,fvjkl" ==
             input
             |> AllergenAssessment.parse()
             |> PartTwo.canonical_dangerous_ingredient_list()
  end
end
