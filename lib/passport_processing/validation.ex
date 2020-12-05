defmodule PassportProcessing.Validation do
  @moduledoc """
  Validation of passports
  """

  @required_keys [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid]

  @spec is_valid?(map(), boolean) :: boolean
  def is_valid?(passport, false) do
    Enum.all?(@required_keys, &Map.has_key?(passport, &1))
  end

  def is_valid?(%{byr: byr, iyr: iyr, eyr: eyr, hgt: hgt, hcl: hcl, ecl: ecl, pid: pid}, true) do
    is_valid_byr?(byr) && is_valid_iyr?(iyr) && is_valid_eyr?(eyr) && is_valid_hgt?(hgt) &&
      is_valid_hcl?(hcl) && is_valid_ecl?(ecl) && is_valid_pid?(pid)
  end

  def is_valid?(_, true), do: false

  defp is_valid_year?(year, min, max) do
    year_int = String.to_integer(year)
    year_length = String.length(year)
    year_length == 4 && year_int >= min && year_int <= max
  end

  defp is_valid_byr?(byr), do: is_valid_year?(byr, 1920, 2002)
  defp is_valid_iyr?(iyr), do: is_valid_year?(iyr, 2010, 2020)
  defp is_valid_eyr?(eyr), do: is_valid_year?(eyr, 2020, 2030)

  defp is_valid_hgt?(hgt) do
    case Regex.run(~r/(\d+)(in|cm)/, hgt) do
      nil -> false
      [_, height, unit] -> is_valid_height?(height, unit)
    end
  end

  defp is_valid_height?(height, unit) do
    height = String.to_integer(height)

    case(unit) do
      "cm" -> height >= 150 && height <= 193
      "in" -> height >= 59 && height <= 76
    end
  end

  defp is_valid_hcl?(hcl), do: String.match?(hcl, ~r/^#[0-z]{6}$/)

  defp is_valid_ecl?("amb"), do: true
  defp is_valid_ecl?("blu"), do: true
  defp is_valid_ecl?("brn"), do: true
  defp is_valid_ecl?("gry"), do: true
  defp is_valid_ecl?("grn"), do: true
  defp is_valid_ecl?("hzl"), do: true
  defp is_valid_ecl?("oth"), do: true
  defp is_valid_ecl?(_), do: false

  defp is_valid_pid?(pid), do: String.match?(pid, ~r/^[0-9]{9}$/)
end
