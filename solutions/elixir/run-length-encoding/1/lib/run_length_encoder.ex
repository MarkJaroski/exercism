defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    String.graphemes(string)
    |> do_encode()
  end

  defp do_encode(s, acc \\ [], out \\ "")
  defp do_encode([], [], out), do: out
  defp do_encode([curr | t], acc, out) do
    next = Enum.at(t, 0)
    cond do
      curr == next -> do_encode(t, [curr | acc], out)
      length(acc) == 0 -> do_encode(t, [], out <> curr)
      true -> do_encode(t, [], out <> to_string(length(acc) + 1) <> curr)
    end
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
      Regex.scan(~r/(\d*)([^\d])/, string)
       |> Enum.reduce("", fn x, acc -> acc <> expand(x) end)
  end

  defp expand([_, "", char]), do: char
  defp expand([_, count, char]) do
    String.duplicate(char, String.to_integer(count))
  end

end
