defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance(~c"AAGTCATA", ~c"TAGCGATC")
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) when length(strand1) != length(strand2) do
    {:error, "strands must be of equal length"}
  end
  def hamming_distance(strand1, strand2) do
    {:ok, do_hamming_distance(strand1, strand2)}
  end

  defp do_hamming_distance(strand1, strand2, acc \\ 0)
  defp do_hamming_distance([], [], acc), do: acc
  defp do_hamming_distance(strand1, strand2, acc) do
    [ h1 | t1 ] = strand1
    [ h2 | t2 ] = strand2
    acc = cond do
      h1 != h2 -> acc + 1
      true -> acc
    end
    do_hamming_distance(t1, t2, acc)
  end
end
