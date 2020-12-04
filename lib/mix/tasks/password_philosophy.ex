defmodule Mix.Tasks.PasswordPhilosophy do
  use Mix.Task

  @shortdoc "Report the number of valid password"

  @moduledoc """
  Given the input file priv/input_02.txt report the number of valid password

  1-3 a: abcde

  means that abcde is valid as it has 1-3 a's.


  ## Example

  mix password_philosophy
  """

  def run([]) do
    File.stream!("priv/input_02.txt")
    |> PasswordPhilosophy.run()
    |> Integer.to_string()
    |> Mix.shell().info()
  end
end
