defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(n) when n == 1, do: []
  def factors_for(n) when n == 2, do: [2]
  def factors_for(n) when n == 3, do: [3]
  def factors_for(n), do: factorize(n, 2, []) |> Enum.reverse()

  defp factorize(1, _, acc), do: acc
  defp factorize(n, c, acc) when rem(n, c) == 0 do
    factorize(div(n, c), c, [c | acc])
  end
  defp factorize(n, c, acc) do
    cond do
      prime?(n) -> [n | acc]
      # skip even numbers
      rem(c, 2) == 0 -> factorize(n, next_prime(c + 1), acc)
      true -> factorize(n, next_prime(c + 2), acc)
    end
  end

  defp next_prime(candidate) when candidate == 2, do: 2
  defp next_prime(candidate) when candidate > 2 do
    cond do
      prime?(candidate) -> candidate
      true -> next_prime(candidate + 1)
    end
  end

  # fermat algorythm
  defp prime?(n) when n in [2, 3], do: true
  defp prime?(n) do
    floored_sqrt = :math.sqrt(n)
      |> Float.floor
      |> round
    !Enum.any?(2..floored_sqrt, &(rem(n, &1) == 0))
  end
end
