defmodule BinaryBoarding do
  @moduledoc """
  Handling binary boarding tickets
  """

  @spec seat_id(<<_::80>>) :: number
  def seat_id(input) do
    input
    |> String.replace(~r/[FL]/, "0")
    |> String.replace(~r/[BR]/, "1")
    |> String.to_integer(2)
  end
end
