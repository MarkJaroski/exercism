defmodule EliudsEggs do
  @doc """
  Given the number, count the number of eggs.
  """
  @spec egg_count(number :: integer()) :: non_neg_integer()
  def egg_count(0), do: 0
  def egg_count(n), do: Bitwise.&&&(n, 1) + egg_count(Bitwise.>>>(n, 1))
end
