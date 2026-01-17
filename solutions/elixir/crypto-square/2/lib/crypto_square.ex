defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""

  def encode(str) do
    normalize(str)
    |> do_encrypt()
  end

  defp normalize(str) do
    str
    |> String.replace(~r/\W/, "")
    |> String.downcase()
    |> String.graphemes()
  end

  defp do_encrypt([]), do: ""

  defp do_encrypt(grph) do
    l = length(grph)
    c = ceil(:math.sqrt(l))

    rows =
      grph
      |> Enum.chunk_every(c)

    for i <- 0..(c - 1) do
      for row <- rows, do: Enum.at(row, i)
    end
    |> Enum.map(fn r ->
      Enum.join(r, "")
      |> String.pad_trailing(length(rows))
    end)
    |> Enum.join(" ")
  end
end
