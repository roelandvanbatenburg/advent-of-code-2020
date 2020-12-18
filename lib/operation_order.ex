defmodule OperationOrder do
  @moduledoc """
  Do the math
  """

  defmodule Token do
    @moduledoc "math tokens"
    @enforce_keys [:type, :value]
    defstruct [:type, :value]

    @tokens %{
      int: "INTEGER",
      op: "OPERATOR",
      leftparen: "(",
      rightparen: ")"
    }

    def create(type: type, value: value) do
      if Map.has_key?(@tokens, type) do
        %__MODULE__{type: type, value: value}
      end
    end
  end

  @spec calculate(list(String.t())) :: list(integer)
  def calculate(input, op_precedence \\ %{"+" => 1, "*" => 1}) do
    input
    |> Enum.map(&calculate_line(&1, op_precedence))
  end

  defp calculate_line(line, op_precedence) do
    line
    |> String.graphemes()
    |> tokenize([])
    |> parse_tokens(op_precedence)
    |> interp()
  end

  defp tokenize([], tokens), do: Enum.reverse(tokens)

  defp tokenize([ch | rest] = chars, tokens) do
    cond do
      is_digit(ch) -> read_number(chars, tokens)
      is_whitespace(ch) -> tokenize(rest, tokens)
      true -> read_next_thing(chars, tokens)
    end
  end

  defp is_digit(char), do: "0" <= char && char <= "9"
  defp is_whitespace(char), do: char == " "

  defp read_number(chars, tokens) do
    {number, rest} = Enum.split_while(chars, fn ch -> is_digit(ch) end)
    number = Enum.join(number)
    token = Token.create(type: :int, value: String.to_integer(number))
    tokenize(rest, [token | tokens])
  end

  defp read_next_thing([ch | rest], tokens) do
    token =
      case ch do
        "+" -> Token.create(type: :op, value: ch)
        "*" -> Token.create(type: :op, value: ch)
        "(" -> Token.create(type: :leftparen, value: ch)
        ")" -> Token.create(type: :rightparen, value: ch)
      end

    tokenize(rest, [token | tokens])
  end

  defp parse_tokens(token, op_precedence, op_stack \\ [], output_queue \\ [])

  defp parse_tokens([], _op_precedence, op_stack, output_queue),
    do: Enum.reverse(output_queue) ++ op_stack

  defp parse_tokens([token | rest], op_precedence, op_stack, output_queue) do
    case token.type do
      :int -> handle_number(token, rest, op_stack, output_queue, op_precedence)
      :op -> handle_op(token, rest, op_stack, output_queue, op_precedence)
      :leftparen -> handle_left_paren(token, rest, op_stack, output_queue, op_precedence)
      :rightparen -> handle_right_paren(token, rest, op_stack, output_queue, op_precedence)
    end
  end

  defp handle_number(num_token, tokens, op_stack, output_queue, op_precedence) do
    output_queue = [num_token | output_queue]
    parse_tokens(tokens, op_precedence, op_stack, output_queue)
  end

  defp handle_op(op_token, tokens, op_stack, output_queue, op_precedence) do
    {moved_ops, op_stack} =
      Enum.split_while(op_stack, fn x ->
        x.value != "(" && op_precedence[x.value] >= op_precedence[op_token.value]
      end)

    output_queue = Enum.reverse(moved_ops) ++ output_queue
    op_stack = [op_token | op_stack]
    parse_tokens(tokens, op_precedence, op_stack, output_queue)
  end

  defp handle_left_paren(lparen_token, tokens, op_stack, output_queue, op_precedence) do
    op_stack = [lparen_token | op_stack]
    parse_tokens(tokens, op_precedence, op_stack, output_queue)
  end

  defp handle_right_paren(_rparen_token, tokens, op_stack, output_queue, op_precedence) do
    {moved_ops, op_stack} = Enum.split_while(op_stack, fn x -> x.value != "(" end)

    output_queue = Enum.reverse(moved_ops) ++ output_queue
    [_ | op_stack] = op_stack
    parse_tokens(tokens, op_precedence, op_stack, output_queue)
  end

  defp interp(tokens, stack \\ [])
  defp interp([], [result | _stack]), do: result.value

  defp interp([token | rest], stack) do
    case token.type do
      :op -> interp_op(token, rest, stack)
      :int -> interp_number(token, rest, stack)
    end
  end

  defp interp_op(op_token, tokens, stack) do
    [op_2_token | stack] = stack
    [op_1_token | stack] = stack
    op_1 = op_1_token.value
    op_2 = op_2_token.value

    result =
      case op_token.value do
        "+" -> Token.create(type: :int, value: op_1 + op_2)
        "*" -> Token.create(type: :int, value: op_1 * op_2)
      end

    stack = [result | stack]
    interp(tokens, stack)
  end

  defp interp_number(num_token, tokens, stack) do
    stack = [num_token | stack]
    interp(tokens, stack)
  end
end
