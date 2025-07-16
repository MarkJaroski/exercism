defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """
  @alphabet_length 26

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    String.downcase(sentence)
    |> String.to_charlist()
    |> Enum.filter(fn x -> x >= ?a && x <= ?z end)
    |> Enum.uniq()
    |> Enum.count()
    == @alphabet_length
  end
end
