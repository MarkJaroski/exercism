defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?([]), do: true
  def chain?(dominoes) do
    case do_chain(dominoes) do
      {:ok, chain} -> ends_match?(chain)
      _ -> false
    end
  end

  defp ends_match?([]), do: true
  defp ends_match?(chain) do
    {f, _} = List.first(chain)
    {_, l} = List.last(chain)
    cond do
      f == l -> true
      true -> false
    end
  end

  defp do_chain(pile, chain \\ [])
  defp do_chain([], chain), do: {:ok, chain}
  defp do_chain([h | t], []), do: do_chain(t, [h])
  defp do_chain(pile, [h | t]) do
    {n, _} = h
    match = best_match(pile, n)

    if match == nil do
      {:error, "broken chain"}
    else
      pile = List.delete(pile, match)
      {l, r} = match 
      cond do
        r == n -> do_chain(pile, [match | [h | t]])
        l == n -> do_chain(pile, [flip(match) | [h | t]])
      end
    end

  end

  defp best_match(pile, n) do
    match = pile
    |> Enum.find(fn {lx, rx} -> n == lx and n == rx end)

    if match == nil, do: first_match(pile, n), else: match
  end

  defp first_match(pile, n) do
    pile
    |> Enum.find(fn x -> 
      {lx, rx} = x
      cond do
        n == lx -> true
        n == rx -> true
        true -> false
      end
    end)
  end

  defp flip({l, r}), do: {r, l}

end
