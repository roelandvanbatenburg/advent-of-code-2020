defmodule PassportProcessing do
  @moduledoc """
  Find the number of valid passports
  """

  def run(input) do
    input
    |> parse_to_passports
    |> Enum.filter(&is_valid/1)
    |> length()
  end

  defp parse_to_passports(input) do
    input
    |> Enum.join("\n")
    |> String.split("\n\n")
    |> Enum.map(&parse_to_passport/1)
  end

  defp parse_to_passport(input) do
    input
    |> String.replace("\n", " ")
    |> String.split(" ")
    |> Enum.map(&parse_property/1)
    |> Map.new()
  end

  defp parse_property(input) do
    [key, value] = String.split(input, ":")
    {String.to_atom(key), value}
  end

  @required_keys [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid]

  defp is_valid(passport) do
    Enum.all?(@required_keys, &Map.has_key?(passport, &1))
  end
end
