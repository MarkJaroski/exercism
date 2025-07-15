defmodule Anagram do
  @moduledoc """
    Functions providing anagrams
   """
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    b = String.downcase(base)
    candidates
    |> Enum.reduce([], fn c, acc -> 
      cond do
        b == String.downcase(c) -> acc
        test_anagram(b, String.downcase(c)) -> [c | acc]
        true -> acc
      end
    end)
    |> Enum.reverse
  end

  defp test_anagram(base, c) do
    String.graphemes(base) |> Enum.sort() == String.graphemes(c) |> Enum.sort
  end
end
