defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    sentence
    |> String.downcase()
    |> String.graphemes()
    |> Enum.filter(fn c -> c != "-" and c != " " end)
    |> Enum.uniq()
    |> Enum.count()
    == sentence
    |> String.graphemes()
    |> Enum.filter(fn c -> c != "-" and c != " " end)
    |> Enum.count()
  end
end
