defmodule SecretHandshake do
  @components %{
    1 => "wink",
    2 => "double blink",
    4 => "close your eyes",
    8 => "jump"
  }
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    Map.keys(@components)
      |> Enum.sort
      |> Enum.reverse
      |> Enum.reduce([], fn key, acc -> 
        if Bitwise.band(code, key) == key, 
          do: [@components[key] | acc], 
          else: acc
        end)
      |> reverse_if(Bitwise.band(code, 16) == 16)
  end

  defp reverse_if(list, cond) do
    if cond, do: Enum.reverse(list), else: list
  end

end
