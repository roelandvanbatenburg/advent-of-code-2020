defmodule Mix.Tasks.ComboBreaker do
  use Mix.Task

  @shortdoc "Day 25"

  @moduledoc """
  Open the door

  ## Example

  mix combo_breaker
  """

  def run([]) do
    ComboBreaker.get_encryption_key(13_316_116, 13_651_422)
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
