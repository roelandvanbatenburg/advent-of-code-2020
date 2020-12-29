defmodule ComboBreaker do
  @moduledoc """
  Breaking and entering
  """

  @spec get_encryption_key(integer, integer) :: integer
  def get_encryption_key(public_key_card, public_key_door) do
    public_key_card
    |> get_private_key()
    |> apply_private_key(public_key_door)
  end

  defp get_private_key(public_key, value \\ 1, loop \\ 0)
  defp get_private_key(card_key, card_key, loop), do: loop

  defp get_private_key(card_key, value, loop) do
    get_private_key(card_key, rem(value * 7, 20_201_227), loop + 1)
  end

  defp apply_private_key(private_key, subject_number, value \\ 1)
  defp apply_private_key(0, _subject_number, value), do: value

  defp apply_private_key(private_key, subject_number, value) do
    apply_private_key(private_key - 1, subject_number, rem(value * subject_number, 20_201_227))
  end
end
