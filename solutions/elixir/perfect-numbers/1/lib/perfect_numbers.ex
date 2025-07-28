defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number < 1 do 
    {:error, "Classification is only possible for natural numbers."}
  end
  def classify(number) when number == 1, do: {:ok, :deficient}
  def classify(number) do
    aliquot = factor(number)
    |> Enum.sum()

    cond do
      aliquot == number -> {:ok, :perfect}
      aliquot > number  -> {:ok, :abundant}
      aliquot < number  -> {:ok, :deficient}
    end

  end

  # Naive factoring. This could be loads more efficient.
  defp factor(n, i \\ 2, factors \\ [1])
  defp factor(n, i, f) when i == n, do: f
  defp factor(n, i, f) when rem(n, i) == 0, do: factor(n, i + 1, [i | f])
  defp factor(n, i, f), do: factor(n, i + 1, f)

end
