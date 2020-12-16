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
      |> Enum.sort(fn {_position_a, bus_id_a}, {_position_b, bus_id_b} -> bus_id_a < bus_id_b end)
      |> Enum.to_list()
    end

    def find_subsequent([{position_a, bus_id_a} | [{position_b, bus_id_b} | rest]]) do
      {timestamp, _product} =
        find_pair({position_a, bus_id_a, 1}, {position_b, bus_id_b, 1})
        |> find_subsequent(rest, Time.utc_now())

      timestamp
    end

    def find_subsequent({t, product}, [{position_a, bus_id_a} | rest], prev) do
      find_next({product, t, 1}, {position_a, bus_id_a, trunc(t / bus_id_a)})
      |> find_subsequent(rest, prev)
    end

    def find_subsequent(t, [], _prev), do: t

    def find_pair({pos_a, id_a, factor_a}, {pos_b, id_b, factor_b}) do
      a = factor_a * id_a - pos_a
      b = factor_b * id_b - pos_b

      if a == b do
        {a, id_a * id_b}
      else
        if a > b do
          find_pair({pos_a, id_a, factor_a}, {pos_b, id_b, factor_b + 1})
        else
          find_pair({pos_a, id_a, factor_a + 1}, {pos_b, id_b, factor_b})
        end
      end
    end

    def find_next({product, timestamp, factor_a} = a_in, {pos, id, factor}) do
      a = timestamp + product * factor_a
      b = factor * id - pos

      if a == b do
        {a, product * id}
      else
        if a > b do
          find_next(a_in, {pos, id, factor + 1})
        else
          find_next(
            {product, timestamp, factor_a + 1},
            {pos, id, trunc((factor_a + 1) * product / id)}
          )
        end
      end
    end

    defp parse_bus_id("x"), do: nil
    defp parse_bus_id(id), do: String.to_integer(id)
  end
end
