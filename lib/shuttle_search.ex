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
end
