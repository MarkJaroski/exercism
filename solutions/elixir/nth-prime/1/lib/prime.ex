defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(n, candidate \\ 2, count \\ 0)
  def nth(n, candidate, count) when n > 0 and n == count, do: candidate - 1
  def nth(n, candidate, count) when n > 0 do
    count = cond do
      is_prime?(candidate) -> count + 1
      true -> count
    end
    nth(n, candidate + 1, count)
  end

  defp is_prime?(n, i \\ 2)
  # for future optimisation
  # def is_prime(n, _) when rem(n, 2) ==0, do: n == 2
  # def is_prime(n, _) when rem(n, 3) ==0, do: n == 3
  defp is_prime?(n, i) when i == n, do: true
  defp is_prime?(n, i) when rem(n, i) == 0, do: false 
  defp is_prime?(n, i) do
    is_prime?(n, i + 1)
  end

end

