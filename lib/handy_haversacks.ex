defmodule HandyHaversacks do
  @moduledoc """
  Things about bags
  """

  @spec number_of_bags_covering_gold(list(String.t())) :: number
  def number_of_bags_covering_gold(input) do
    input
    |> Enum.map(&parse_to_rule/1)
    |> Map.new()
    |> IO.inspect()
    |> find_gold
  end

  @spec number_of_bags_in_gold(list(String.t())) :: number
  def number_of_bags_in_gold(input) do
    rules =
      input
      |> Enum.map(&parse_to_rule/1)
      |> Map.new()

    # remove one for the shiny gold bag
    get_size_by_color("shiny gold", rules) - 1
  end

  # vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
  defp parse_to_rule(rule) do
    [_, color, contains] = Regex.run(~r/(.+) bags contain (.+)\./, rule)
    {color, parse_contains(contains)}
  end

  defp parse_contains("no other bags"), do: nil

  defp parse_contains(contains) do
    contains
    |> String.split(", ")
    |> Enum.map(fn c ->
      [_, count, color] = Regex.run(~r/(\d+) (.+) bag[s]?/, c)
      {color, String.to_integer(count)}
    end)
  end

  defp find_gold(rules) do
    rules
    |> Enum.reduce(0, fn rule, acc ->
      if can_contain_gold?(rule, rules) do
        acc + 1
      else
        acc
      end
    end)
  end

  defp can_contain_gold?({_color, nil}, _rules), do: false

  defp can_contain_gold?({_color, rule}, rules) do
    if Enum.find(rule, false, fn {color, _count} -> color == "shiny gold" end) do
      true
    else
      rule
      |> Enum.map(fn {rule_color, _count} -> {rule_color, Map.get(rules, rule_color)} end)
      |> Enum.any?(fn rule -> can_contain_gold?(rule, rules) end)
    end
  end

  defp get_size_by_color(color, rules) do
    rule = Map.get(rules, color)
    get_size_by_rule(rule, rules)
  end

  defp get_size_by_rule(nil, _rules), do: 1

  defp get_size_by_rule(rule, rules) do
    contains =
      rule
      |> Enum.reduce(0, fn {color, count}, acc ->
        acc + count * get_size_by_color(color, rules)
      end)

    # add one for bag itself
    contains + 1
  end
end
