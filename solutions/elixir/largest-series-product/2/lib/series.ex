defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  
  def largest_product(_number_string, size) when size < 1, do: raise(ArgumentError)
  def largest_product(number_string, size) do
    cl = number_string |> String.to_charlist()

    if Enum.count(cl) < size, do: raise(ArgumentError)

    cl
    |> Enum.map(fn x -> 
      cond do
        x > ?9 -> raise(ArgumentError)
        x < ?0 -> raise(ArgumentError)
        true -> x - ?0 
      end
    end)
    |> Enum.chunk_every(size, 1, :discard)
    |> Enum.map(&Enum.product(&1))
    |> Enum.sort()
    |> List.last()
  end
end
