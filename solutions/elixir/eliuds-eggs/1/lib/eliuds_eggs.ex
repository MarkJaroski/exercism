defmodule EliudsEggs do
  @doc """
  Given the number, count the number of eggs.
  """
  @spec egg_count(number :: integer()) :: non_neg_integer()
  def egg_count(number) do
    Enum.to_list(1..100)
    |> Enum.reduce([1], fn x, acc -> [2 ** x | acc] end)
    |> Enum.reverse()
    |> Enum.reduce(0, fn x, acc -> 
      if Bitwise.band(number, x) == x, do: acc + 1, else: acc
    end)
  end
end
