defmodule BinaryBoarding do
  @moduledoc """
  Handling binary boarding tickets
  """

  @spec parse(<<_::80>>) :: {non_neg_integer, non_neg_integer}
  def parse(<<row::binary-size(7), column::binary-size(3)>>) do
    {parse_row(row), parse_column(column)}
  end

  def id({column, row}), do: column * 8 + row

  defp parse_row(<<"F", rest::binary>>), do: 0 + parse_row(rest)
  defp parse_row(<<"B", rest::binary-size(6)>>), do: 64 + parse_row(rest)
  defp parse_row(<<"B", rest::binary-size(5)>>), do: 32 + parse_row(rest)
  defp parse_row(<<"B", rest::binary-size(4)>>), do: 16 + parse_row(rest)
  defp parse_row(<<"B", rest::binary-size(3)>>), do: 8 + parse_row(rest)
  defp parse_row(<<"B", rest::binary-size(2)>>), do: 4 + parse_row(rest)
  defp parse_row(<<"B", rest::binary-size(1)>>), do: 2 + parse_row(rest)
  defp parse_row("B"), do: 1
  defp parse_row(""), do: 0

  defp parse_column(<<"L", rest::binary>>), do: 0 + parse_column(rest)
  defp parse_column(<<"R", rest::binary-size(2)>>), do: 4 + parse_column(rest)
  defp parse_column(<<"R", rest::binary-size(1)>>), do: 2 + parse_column(rest)
  defp parse_column("R"), do: 1
  defp parse_column(""), do: 0
end
