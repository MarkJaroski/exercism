defmodule CollatzConjecture do
  @moduledoc """
   Functions for calculating the Collatz Conjecture 
   distance for a given integer
   """

  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) when is_integer(input) and input > 0 do
    next_step(input)
  end

  defp next_step(n, step \\ 0)
  defp next_step(1, step), do: step
  defp next_step(n, step) do
    next = cond do
      rem(n, 2) == 0 -> div(n, 2)
      true -> (n * 3) + 1
    end
    next_step(next, step + 1)
  end
end
