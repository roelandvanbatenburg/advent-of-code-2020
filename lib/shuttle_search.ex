defmodule ShuttleSearch do
  @moduledoc """
  Find the bus
  """

  defmodule PartOne do
    @moduledoc """
    First puzzle
    """

    @spec parse_bus_line(String.t()) :: list(integer)
    def parse_bus_line(input) do
      input
      |> String.split(",")
      |> Enum.filter(fn bus_id -> bus_id != "x" end)
      |> Enum.map(fn bus_id -> String.to_integer(bus_id) end)
    end

    @spec find_bus(integer, list(integer)) :: {integer, integer}
    def find_bus(timestamp, busses) do
      case Enum.find(busses, fn bus_id -> rem(timestamp, bus_id) == 0 end) do
        nil -> find_bus(timestamp + 1, busses)
        bus_id -> {timestamp, bus_id}
      end
    end
  end

  defmodule PartTwo do
    @moduledoc """
    Second puzzle
    """

    @spec parse_bus_line(String.t()) :: list({integer, integer})
    def parse_bus_line(input) do
      bus_numbers = String.split(input, ",")

      busses =
        0..(length(bus_numbers) - 1)
        |> Enum.map(fn index -> {index, parse_bus_id(Enum.at(bus_numbers, index))} end)

      busses
      |> Enum.filter(fn {_position, bus_id} -> bus_id != nil end)
      |> Enum.sort(fn {_position_a, bus_id_a}, {_position_b, bus_id_b} -> bus_id_a > bus_id_b end)
      |> Enum.to_list()
    end

    def find_subsequent(busses) do
      busses
      |> Enum.reduce([], fn {position, bus_id}, acc ->
        acc
        |> IO.inspect()
        |> Enum.concat(factors_for(bus_id + position))
        |> IO.inspect()
        |> Enum.uniq()
        |> IO.inspect()
      end)
      |> Enum.reduce(fn factor, product -> product * factor end)
    end

    @spec factors_for(pos_integer) :: [pos_integer]
    def factors_for(number) do
      number |> f |> Enum.reverse()
    end

    def f(a, test \\ 2, acc \\ [])
    def f(1, _, acc), do: acc

    def f(number, test, acc) when rem(number, test) == 0,
      do: f(div(number, test), test, [test | acc])

    def f(number, test, acc), do: f(number, test + 1, acc)

    defp parse_bus_id("x"), do: nil
    defp parse_bus_id(id), do: String.to_integer(id)
  end
end
