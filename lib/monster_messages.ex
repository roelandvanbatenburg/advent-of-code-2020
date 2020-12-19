defmodule MonsterMessages do
  @moduledoc """
  Listen to the beast
  """

  @spec parse(String.t()) :: {map(), list(String.t())}
  def parse(input) do
    [rules, messages] = String.split(input, "\n\n")

    rules =
      rules
      |> String.split("\n")
      |> Enum.map(&parse_rule/1)
      |> Map.new()

    {rules, String.split(messages, "\n")}
  end

  defp parse_rule(input) do
    [id, rule] = String.split(input, ": ")
    {id, rule}
  end

  def rule_to_regex(rules, rule_id \\ "0") do
    regex_from_rule(Map.get(rules, rule_id), rules)
  end

  defp regex_from_rule(rule, rules, acc \\ "") do
    if String.starts_with?(rule, "\"") do
      acc <> String.at(rule, 1)
    else
      if String.contains?(rule, "|") do
        acc <> regex_from_alternation(rule, rules)
      else
        acc <> (String.split(rule, " ") |> Enum.map(&rule_to_regex(rules, &1)) |> Enum.join(""))
      end
    end
  end

  defp regex_from_alternation("42 | 42 8", rules) do
    pattern = rule_to_regex(rules, "42")
    "(?<eight>#{pattern}+)"
  end

  defp regex_from_alternation("42 31 | 42 11 31", rules) do
    forty_two = rule_to_regex(rules, "42")
    thirty_one = rule_to_regex(rules, "31")

    "((?<eleven1>#{forty_two})+(?<eleven2>#{thirty_one})+)"
  end

  defp regex_from_alternation(rule, rules) do
    alternation =
      rule
      |> String.split(" | ")
      |> Enum.map(&regex_from_rule(&1, rules))
      |> Enum.join("|")

    "(#{alternation})"
  end

  defmodule PartOne do
    @moduledoc """
    First puzzle
    """
    @spec valid_messages({map(), list(String.t())}) :: integer
    def valid_messages({rules, messages}) do
      regex = Regex.compile!("^#{MonsterMessages.rule_to_regex(rules)}$")

      Enum.reduce(messages, 0, fn message, acc ->
        if Regex.match?(regex, message) do
          acc + 1
        else
          acc
        end
      end)
    end
  end

  defmodule PartTwo do
    @moduledoc """
    Second puzzle
    """
    @spec valid_messages({map(), list(String.t())}) :: integer
    def valid_messages({rules, messages}) do
      rules =
        rules
        |> Map.put("8", "42 | 42 8")
        |> Map.put("11", "42 31 | 42 11 31")

      regex = Regex.compile!("^#{MonsterMessages.rule_to_regex(rules)}$")

      Enum.reduce(messages, 0, fn message, acc ->
        if Regex.match?(regex, message) && valid_eleven?(regex, message) do
          acc + 1
        else
          acc
        end
      end)
    end

    defp valid_eleven?(regex, message) do
      names = Regex.named_captures(regex, message)
      String.length(Map.get(names, "eleven1")) == String.length(Map.get(names, "eleven2"))
    end
  end
end
