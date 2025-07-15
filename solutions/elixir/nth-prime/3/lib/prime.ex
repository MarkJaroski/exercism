defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(n), do: do_nth(n)

  defp do_nth(n, candidate \\ 2, count \\ 0)
  defp do_nth(n, candidate, count) when n > 0 and n == count, do: candidate - 1
  defp do_nth(n, candidate, count) when n > 0 do
    count = cond do
      prime?(candidate) -> count + 1
      true -> count
    end
    do_nth(n, candidate + 1, count)
  end

  defp prime?(n, i \\ 2)
  # for future optimisation
  # def prime(n, _) when rem(n, 2) ==0, do: n == 2
  # def prime(n, _) when rem(n, 3) ==0, do: n == 3
  defp prime?(n, i) when i == n, do: true
  defp prime?(n, i) when rem(n, i) == 0, do: false 
  defp prime?(n, i) do
    prime?(n, i + 1)
  end

end

