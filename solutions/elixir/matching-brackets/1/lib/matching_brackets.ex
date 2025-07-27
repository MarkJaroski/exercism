defmodule MatchingBrackets do
  @brackets %{
      "[" => "]",
      "(" => ")",
      "{" => "}"
    }
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    String.graphemes(str) |> balanced?()
  end

  defp balanced?(str, stack \\ [])
  defp balanced?([], []), do: true
  defp balanced?([], _), do: false
  defp balanced?([h | t], []) do
    cond do
      Enum.member?(Map.keys(@brackets), h) -> balanced?(t, [ h ])
      Enum.member?(Map.values(@brackets), h) -> false
      true -> balanced?(t, [])
    end
  end
  defp balanced?([h | t], [p | r] = stack) do
    cond do
      Enum.member?(Map.keys(@brackets), h) -> balanced?(t, [ h | stack])
      Map.get(@brackets, p) == h -> balanced?(t, r)
      Enum.member?(Map.values(@brackets), h) -> false
      true -> balanced?(t, stack)
    end
  end

end
