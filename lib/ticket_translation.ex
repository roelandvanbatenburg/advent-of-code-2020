defmodule TicketTranslation do
  @moduledoc """
  Decode tickets
  """

  @spec parse_input(list(String.t())) ::
          {list({String.t(), list(integer)}), list(integer), list(list(integer))}
  def parse_input(input) do
    [rules_input, your_ticket_input, nearby_tickets_input] =
      input |> Enum.join("\n") |> String.split("\n\n")

    rules = rules_input |> String.split("\n") |> Enum.map(&parse_rule/1)
    your_ticket = your_ticket_input |> String.split("\n") |> List.last() |> parse_ticket()

    nearby_tickets =
      nearby_tickets_input |> String.split("\n") |> Enum.drop(1) |> Enum.map(&parse_ticket/1)

    {rules, your_ticket, nearby_tickets}
  end

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

    @spec error_rate({list({String.t(), list(integer)}), list(integer), list(list(integer))}) ::
            integer
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
  end
end
