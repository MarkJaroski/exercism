defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""
  def recite(strings) do
    [h | _] = strings
    out = "And all for the want of a #{h}.\n"

    [out | do_verse(strings, [])]
    |> Enum.reverse() 
    |> Enum.join("\n")
  end

  defp do_verse(s, out) when length(s) == 1, do: out
  defp do_verse([h | t], out) do
    [n | _] = t 
    do_verse(t, ["For want of a #{h} the #{n} was lost." | out])
  end
end
