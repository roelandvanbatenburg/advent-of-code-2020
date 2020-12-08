defmodule HandheldHalting do
  @moduledoc """
  Follow the instructions
  """

  @spec run(list(String.t())) :: integer
  def run(input) do
    input
    |> parse_to_instructions
    |> execute()
  end

  defp parse_to_instructions(input) do
    input
    |> Enum.map(&parse_to_instruction/1)
  end

  defp parse_to_instruction(
         <<instruction::binary-size(3), " ", sign::binary-size(1), number::binary>>
       ) do
    value =
      if sign == "-" do
        String.to_integer(sign <> number)
      else
        String.to_integer(number)
      end

    %{
      instruction: instruction,
      value: value
    }
  end

  defp execute(instructions, instruction_index \\ 0, value \\ 0, visited \\ []) do
    if Enum.member?(visited, instruction_index) do
      value
    else
      [next_instruction_index, next_value] =
        case Enum.at(instructions, instruction_index) do
          %{instruction: "nop", value: _value} ->
            [instruction_index + 1, value]

          %{instruction: "acc", value: instruction_value} ->
            [instruction_index + 1, value + instruction_value]

          %{instruction: "jmp", value: instruction_value} ->
            [instruction_index + instruction_value, value]
        end

      execute(instructions, next_instruction_index, next_value, [instruction_index | visited])
    end
  end
end
