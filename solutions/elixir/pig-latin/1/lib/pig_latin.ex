defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase 
    |> String.downcase()
    |> String.split() 
    |> Enum.map(fn x -> translate_word(x) end)
    |> Enum.join(" ")
  end

  defp translate_word(word) do
    cond do
      String.match?(word, ~r/^[aeiou]/) -> rule1(word)
      String.match?(word, ~r/^xr/) -> rule1(word)
      String.match?(word, ~r/^yt/) -> rule1(word)
      String.match?(word, ~r/^[bcdfghjklmnpqrstvwxyz]*qu/) -> rule3(word)
      String.match?(word, ~r/^[bcdfghjklmnpqrstvwxyz]+y/) -> rule4(word)
      String.match?(word, ~r/^[bcdfghjklmnpqrstvwxyz]/) -> rule2(word)
      true -> word
    end
  end

  defp rule1(word) do
    word <> "ay"
  end

  defp rule2(word) do
    [prefix] = Regex.run(~r/^[bcdfghjklmnpqrstvwxyz]+/, word)
    String.replace_prefix(word, prefix, "") <> prefix <> "ay"
  end

  defp rule3(word) do
    [prefix] = Regex.run(~r/^[bcdfghjklmnpqrstvwxyz]*qu/, word)
    String.replace_prefix(word, prefix, "") <> prefix <> "ay"
  end

  defp rule4(word) do
    [prefix] = Regex.run(~r/^[bcdfghjklmnpqrstvwxz]+/, word)
    String.replace_prefix(word, prefix, "") <> prefix <> "ay"
  end

end
