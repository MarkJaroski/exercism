defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    do_binary(Tuple.to_list(numbers) |> Enum.sort(), key)
  end

  defp do_binary(numbers, key, start_i \\ 0)
  defp do_binary([], _, _), do: :not_found
  defp do_binary(numbers, key, start_i) do
    mid= div(length(numbers), 2)
    cand = Enum.at(numbers, mid)
    cond do
      cand === key -> {:ok, mid + start_i}
      cand < key -> do_binary(Enum.slice(numbers, mid + 1, mid), key, start_i + mid + 1)
      cand > key -> do_binary(Enum.slice(numbers, 0, mid), key, start_i)
    end
  end
end
