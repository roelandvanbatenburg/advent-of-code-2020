defmodule CrabCombat do
  @moduledoc """
  Play Combat
  """

  @type hand :: list(integer)
  @type deck :: {hand(), hand()}

  @spec parse(String.t()) :: deck()
  def parse(input) do
    [hand1, hand2] = String.split(input, "\n\n")
    {parse_hand(hand1), parse_hand(hand2)}
  end

  defp parse_hand(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.drop(1)
    |> Enum.map(&String.to_integer/1)
  end

  @spec score(hand()) :: integer
  def score(hand) do
    reversed_hand = Enum.reverse(hand)

    0..(length(hand) - 1)
    |> Enum.reduce(0, fn i, score -> score + (i + 1) * Enum.at(reversed_hand, i) end)
  end

  defmodule PartOne do
    @moduledoc """
    First puzzle
    """

    @spec play(CrabCombat.deck()) :: CrabCombat.hand()
    def play({[], winner}), do: winner
    def play({winner, []}), do: winner

    def play({[card1 | hand1], [card2 | hand2]}) do
      if card1 > card2 do
        {hand1 ++ [card1, card2], hand2}
      else
        {hand1, hand2 ++ [card2, card1]}
      end
      |> play()
    end
  end

  defmodule PartTwo do
    @moduledoc """
    Second puzzle
    """
  end
end
