defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    Stream.iterate([1], fn n -> 
      0..length(n)
      |> Range.to_list()
      |> Enum.map(fn k ->
        cond do
          k == 0 -> 1
          Enum.at(n, k) == nil -> 1
          true -> Enum.at(n, k - 1) + Enum.at(n, k)
        end
      end)
    end)
    |> Enum.take(num)
  end
end
