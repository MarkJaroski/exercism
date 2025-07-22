defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  # def compare([], []), do: :equal
  def compare(a, b) when a == b, do: :equal
  def compare(a, []) when length(a) > 0, do: :superlist
  def compare([], b) when length(b) > 0, do: :sublist
  def compare(a, b) when length(a) > length(b) do
    cond do
      contains?(a, b) -> :superlist
      true -> :unequal
    end
  end
  def compare(a, b) when length(a) < length(b) do
    cond do
      contains?(b, a) -> :sublist
      true -> :unequal
    end
  end
  def compare(_, _), do: :unequal



  defp contains?(big, small) when length(big) < length(small), do: false
  defp contains?(big, small) do
    [f | _] = small
    i = Enum.find_index(big, fn x -> x === f end)
    cond do
      i == nil -> false
      Enum.slice(big, i, length(small)) == small -> true
      true -> contains?(Enum.slice(big, i + 1, length(big)), small)
    end
  end


end
