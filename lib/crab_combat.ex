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
    Recursive Combat
    """

    @spec play(CrabCombat.deck(), list(CrabCombat.deck())) :: CrabCombat.hand()
    def play(deck, played_decks \\ [])
    def play({[], winner}, _), do: winner
    def play({winner, []}, _), do: winner

    def play({[card1 | hand1], [card2 | hand2]} = deck, played_decks) do
      if Enum.member?(played_decks, deck) do
        [card1 | hand1]
      else
        # cannot recurse, high card wins
        if length(hand1) < card1 || length(hand2) < card2 do
          if card1 > card2 do
            {hand1 ++ [card1, card2], hand2}
          else
            {hand1, hand2 ++ [card2, card1]}
          end
        else
          case subgame({Enum.slice(hand1, 0, card1), Enum.slice(hand2, 0, card2)}, played_decks) do
            1 -> {hand1 ++ [card1, card2], hand2}
            2 -> {hand1, hand2 ++ [card2, card1]}
          end
        end
        |> play([deck | played_decks])
      end

      # [7, 5, 6, 2, 4, 1, 10, 8, 9, 3]
    end

    defp subgame({[], _}, _), do: 2
    defp subgame({_, []}, _), do: 1

    defp subgame({[card1 | hand1], [card2 | hand2]} = deck, played_decks) do
      if Enum.member?(played_decks, deck) do
        1
      else
        # cannot recurse, high card wins
        if length(hand1) < card1 || length(hand2) < card2 do
          if card1 > card2 do
            {hand1 ++ [card1, card2], hand2}
          else
            {hand1, hand2 ++ [card2, card1]}
          end
          |> subgame([deck | played_decks])
        else
          subgame({Enum.slice(hand1, 0, card1), Enum.slice(hand2, 0, card2)}, played_decks)
        end
      end
    end
  end
end
