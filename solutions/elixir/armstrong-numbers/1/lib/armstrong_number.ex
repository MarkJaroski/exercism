defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @doc """
  Validates an armstrong number candidate. Returns true or false.
  """
  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = to_digits(number, 10)
    p = length(digits)
    res = Enum.reduce(digits, 0, fn n, acc -> 
      n ** p + acc
    end)
    number == res
  end

  defp to_digits(int, output_base, acc \\ [])
  defp to_digits(0, _, []), do: [0]
  defp to_digits(0, _, acc), do: acc
  defp to_digits(int, output_base, acc) do
    out = div(int, output_base)
    acc = [ rem(int, output_base) | acc]
    to_digits(out, output_base, acc)
  end

end
