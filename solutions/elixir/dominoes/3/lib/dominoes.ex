defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?([]), do: true
  def chain?([{l, r}]), do: l == r

  def chain?([{l, r} | dominoes]) do
    IO.inspect({{l, r}, dominoes})
    dominoes
    |> Enum.any?(fn
        {^l, x} = domino -> chain?([{r, x} | List.delete(dominoes, domino)])
        {x, ^l} = domino -> chain?([{r, x} | List.delete(dominoes, domino)])
        _ -> false
     end)
  end

end
