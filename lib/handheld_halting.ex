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

  @spec solve(list(String.t())) :: integer
  def solve(input) do
    input
    |> parse_to_instructions
    |> find_solution
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
        next_instruction_and_value(
          Enum.at(instructions, instruction_index),
          instruction_index,
          value
        )

      execute(instructions, next_instruction_index, next_value, [instruction_index | visited])
    end
  end

  defp next_instruction_and_value(instruction, index, value) do
    case instruction do
      %{instruction: "nop", value: _instruction_value} -> [index + 1, value]
      %{instruction: "acc", value: instruction_value} -> [index + 1, value + instruction_value]
      %{instruction: "jmp", value: instruction_value} -> [index + instruction_value, value]
    end
  end

  defp find_solution(instructions) do
    i_cnt = length(instructions)

    0..i_cnt
    |> Enum.find_value(&replace_and_execute(instructions, &1))
  end

  defp replace_and_execute(instructions, index) do
    replace_instruction(instructions, index)
    |> execute_if_possible()
  end

  defp execute_if_possible(instructions, instruction_index \\ 0, value \\ 0, visited \\ []) do
    if Enum.member?(visited, instruction_index) do
      nil
    else
      [next_instruction_index, next_value] =
        next_instruction_and_value(
          Enum.at(instructions, instruction_index),
          instruction_index,
          value
        )

      if length(instructions) == next_instruction_index do
        next_value
      else
        execute_if_possible(instructions, next_instruction_index, next_value, [
          instruction_index | visited
        ])
      end
    end
  end

  defp replace_instruction(instructions, index) do
    new_instruction =
      case Enum.at(instructions, index) do
        %{instruction: "nop", value: instruction_value} ->
          %{instruction: "jmp", value: instruction_value}

        %{instruction: "jmp", value: instruction_value} ->
          %{instruction: "nop", value: instruction_value}

        instruction ->
          instruction
      end

    List.replace_at(instructions, index, new_instruction)
  end
end
