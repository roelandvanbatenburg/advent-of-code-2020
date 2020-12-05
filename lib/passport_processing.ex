defmodule PassportProcessing do
  @moduledoc """
  Find the number of valid passports
  """

  alias PassportProcessing.Validation

  @spec run(list(String.t()), boolean) :: integer
  def run(input, strict \\ false) do
    input
    |> parse_to_passports
    |> Enum.filter(&Validation.is_valid?(&1, strict))
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

end
