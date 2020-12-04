defmodule PasswordPhilosophy do
  @moduledoc """
  Find number of valid passwords
  You can use :weird as the second argument for the second half ruling
  """

  @spec run(File.Stream.t(), :normal | :weird) :: non_neg_integer
  def run(stream, weirdly \\ :normal) do
    stream
    |> Stream.filter(&is_valid?(&1, weirdly))
    |> Enum.to_list()
    |> length()
  end

  defp is_valid?(line, :normal) do
    [password, letter, min, max] = parse(line)

    length =
      password
      |> String.graphemes()
      |> Enum.filter(fn element -> element == letter end)
      |> length()

    length >= min && length <= max
  end

  defp is_valid?(line, :weird) do
    [password, letter, first_location, second_location] = parse(line)

    first_matches = String.at(password, first_location - 1) == letter
    second_matches = String.at(password, second_location - 1) == letter

    (first_matches && !second_matches) || (!first_matches && second_matches)
  end

  # unfortunately pattern matching won't work as the length of the numbers is not fixed :(
  defp parse(line) do
    [counts, letter_with_colon, password] = String.split(line, " ")
    [first_number, second_number] = String.split(counts, "-") |> Enum.map(&String.to_integer/1)
    letter = String.replace(letter_with_colon, ":", "")
    [password, letter, first_number, second_number]
  end
end
