defmodule PasswordPhilosophy do
  @moduledoc """
  Find number of valid passwords
  """

  @spec run(File.Stream.t()) :: non_neg_integer
  def run(stream) do
    stream
    |> Stream.filter(&is_valid?/1)
    |> Enum.to_list()
    |> length()
  end

  # unfortunately pattern matching won't work as the length of the numbers is not fixed :(
  defp is_valid?(line) do
    [counts, letter_with_colon, password] = String.split(line, " ")
    [min, max] = String.split(counts, "-") |> Enum.map(&String.to_integer/1)
    letter = String.replace(letter_with_colon, ":", "")

    length =
      password
      |> String.graphemes()
      |> Enum.filter(fn element -> element == letter end)
      |> length()

    length >= min && length <= max
  end
end
