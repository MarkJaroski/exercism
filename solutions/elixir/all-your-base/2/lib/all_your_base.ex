defmodule AllYourBase do
  @moduledoc false
  @message_invalid_out_base "output base must be >= 2"
  @message_invalid_in_base "input base must be >= 2"
  @message_invalid_digit "all digits must be >= 0 and < input base"

  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """
  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_, input_base, _) when input_base < 2 do 
    {:error, @message_invalid_in_base}
  end
  def convert(_, _, output_base) when output_base < 2  do  
    {:error, @message_invalid_out_base}
  end
  def convert([], _, _), do: {:ok, [0]}
  def convert([0], _, _), do: {:ok, [0]}
  def convert(digits, input_base, output_base) do
    if Enum.any?(digits, fn n -> n < 0 or n >= input_base end) do
      {:error, @message_invalid_digit}
    else
      {:ok, to_integer(digits, input_base) |> to_digits(output_base)}
    end
  end

  defp to_integer(digits, input_base) do
    digits
    |> Enum.reverse
    |> Enum.with_index(0)
    |> Enum.reduce(0, fn {n, i}, acc -> 
        acc + n * input_base ** i
      end)
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
