defmodule KillerSudokuHelper do
  @doc """
  Return the possible combinations of `size` distinct numbers from 1-9 excluding `exclude` that sum up to `sum`.
  """
  @spec combinations(cage :: %{exclude: [integer], size: integer, sum: integer}) :: [[integer]]
  def combinations(cage) when cage.size < 1, do: nil
  def combinations(cage) when cage.size == 1, do: [[cage.sum]]
  def combinations(cage) when cage.size == 9, do: [Range.to_list(1..9)]

  def combinations(cage) do
    Range.to_list(1..div(cage.sum, cage.size))
    |> Enum.filter(fn n ->
      !Enum.member?(cage.exclude, n)
    end)
    |> Enum.reduce([], fn n, acc ->

      subsets =
        combinations(%{exclude: cage.exclude, size: cage.size - 1, sum: cage.sum - n})
        |> Enum.map(fn s ->
          cond do
            Enum.member?(s, n) -> []
            true -> Enum.sort([n | s])
          end
        end)
        |> Enum.filter(fn x -> x != [] end)

      cond do
        subsets == [] -> acc
        true -> Enum.concat(acc, subsets)
      end
    end)
    |> Enum.uniq()
  end

end
