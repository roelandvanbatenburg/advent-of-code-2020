defmodule TicketTranslation do
  @moduledoc """
  Decode tickets
  """

  @type inputset :: {map(), list(integer), list(list(integer))}

  @spec parse_input(list(String.t())) :: inputset
  def parse_input(input) do
    [rules_input, your_ticket_input, nearby_tickets_input] =
      input |> Enum.join("\n") |> String.split("\n\n")

    rules = rules_input |> String.split("\n") |> Enum.map(&parse_rule/1) |> Map.new()
    your_ticket = your_ticket_input |> String.split("\n") |> List.last() |> parse_ticket()

    nearby_tickets =
      nearby_tickets_input |> String.split("\n") |> Enum.drop(1) |> Enum.map(&parse_ticket/1)

    {rules, your_ticket, nearby_tickets}
  end

  @spec filter_invalid_tickets(inputset) :: inputset
  def filter_invalid_tickets({rules, ticket, tickets}) do
    valid_tickets =
      tickets
      |> Enum.filter(fn ticket -> Enum.all?(ticket, &is_valid_field?(rules, &1)) end)

    {rules, ticket, valid_tickets}
  end

  defp is_valid_field?(rules, field),
    do: Enum.any?(rules, fn {_name, range} -> Enum.member?(range, field) end)

  defp parse_rule(rule) do
    [name, values_input] = String.split(rule, ": ")

    [range1_raw, range2_raw] = String.split(values_input, " or ")
    [range1_min, range1_max] = range1_raw |> String.split("-") |> Enum.map(&String.to_integer/1)
    [range2_min, range2_max] = range2_raw |> String.split("-") |> Enum.map(&String.to_integer/1)

    {name, Enum.concat(range1_min..range1_max, range2_min..range2_max)}
  end

  defp parse_ticket(line) do
    line
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  defmodule PartOne do
    @moduledoc """
    First puzzle
    """

    @spec error_rate(TicketTranslation.inputset()) :: integer
    def error_rate({rules, _your_ticket, nearby_tickets}) do
      nearby_tickets
      |> Enum.reduce(0, fn ticket, error_rate -> error_rate + ticket_error_rate(rules, ticket) end)
    end

    defp ticket_error_rate(rules, ticket) do
      ticket
      |> Enum.reduce(0, fn field, error_rate -> error_rate + field_error_rate(rules, field) end)
    end

    defp field_error_rate(rules, field) do
      if Enum.any?(rules, fn {_name, range} -> Enum.member?(range, field) end) do
        0
      else
        field
      end
    end
  end

  defmodule PartTwo do
    @moduledoc """
    Second puzzle
    """

    @spec solve(TicketTranslation.inputset()) :: map()
    def solve({rules, _ticket, tickets}) do
      mapping = map_rules_until_done(%{}, rules, tickets, [])
      mapping
    end

    @spec departure_product(map(), list(integer)) :: integer
    def departure_product(solution, ticket) do
      solution
      |> Enum.reduce(1, fn {key, index}, product ->
        case String.starts_with?(key, "departure") do
          true -> product * Enum.at(ticket, index)
          false -> product
        end
      end)
    end

    defp map_rules_until_done(mapping, rules, _tickets, _used_columns) when rules == %{},
      do: mapping

    defp map_rules_until_done(mapping, rules, tickets, used_columns) do
      {{rule_name, _}, column} = find_valid_mapping(rules, tickets, used_columns)

      map_rules_until_done(
        Map.put(mapping, rule_name, column),
        Map.delete(rules, rule_name),
        tickets,
        [column | used_columns]
      )
    end

    defp find_valid_mapping(rules, tickets, used_columns) do
      Enum.find_value(
        rules,
        fn rule ->
          case map_rule_to_tickets(rule, tickets, used_columns) do
            nil -> nil
            rule_and_column -> rule_and_column
          end
        end
      )
    end

    defp map_rule_to_tickets(rule, tickets, used_columns) do
      # ensure that only one column matches with the rule
      last_index = length(List.first(tickets)) - 1

      case Enum.find(0..last_index, &find_valid_rule(&1, rule, tickets, used_columns)) do
        nil -> nil
        hit -> valid_valid_or_nil(hit, last_index, rule, tickets, used_columns)
      end
    end

    defp find_valid_rule(i, rule, tickets, used_columns) do
      if Enum.member?(used_columns, i) do
        nil
      else
        is_valid_rule?(rule, tickets, i)
      end
    end

    defp valid_valid_or_nil(hit, last_index, rule, tickets, used_columns) do
      if hit == last_index do
        {rule, hit}
      else
        case (hit + 1)..last_index
             |> Enum.find(&find_next_valid_rule(&1, rule, tickets, used_columns)) do
          nil -> {rule, hit}
          _ -> nil
        end
      end
    end

    defp find_next_valid_rule(i, rule, tickets, used_columns) do
      if Enum.member?(used_columns, i) do
        nil
      else
        is_valid_rule?(rule, tickets, i)
      end
    end

    defp is_valid_rule?({_rule_name, rule_range}, tickets, column) do
      values = Enum.map(tickets, &Enum.at(&1, column))
      Enum.all?(values, &Enum.member?(rule_range, &1))
    end
  end
end
