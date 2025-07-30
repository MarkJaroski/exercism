defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.trim()
    |> String.replace(~r/[,\n_]/, " ")
    |> String.replace(~r/[":!.@^&$%]/, "")
    |> String.replace(~r/ ,/, " ")
    |> String.replace(~r/, /, " ")
    |> String.replace(~r/ '/, " ")
    |> String.replace(~r/' /, " ")
    |> String.replace(~r/^'/, "")
    |> String.replace(~r/'$/, "")
    |> String.split(~r/\s+/)
    |> Enum.reject(fn c -> c == "" end)
    |> Enum.frequencies()
  end
end
