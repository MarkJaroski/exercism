defmodule SecretHandshake do
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
    []
      |> prepend_if(Bitwise.band(code, 8) == 8, "jump")
      |> prepend_if(Bitwise.band(code, 4) == 4, "close your eyes")
      |> prepend_if(Bitwise.band(code, 2) == 2, "double blink")
      |> prepend_if(Bitwise.band(code, 1) == 1, "wink")
      |> reverse_if(Bitwise.band(code, 16) == 16)
  end

  defp prepend_if(list, cond, item) do
    if cond, do: [item | list], else: list
  end

  defp reverse_if(list, cond) do
    if cond, do: Enum.reverse(list), else: list
  end

end
