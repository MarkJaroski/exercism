defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    v = :math.sqrt(abs(x) ** 2 + abs(y) ** 2)
    cond do
      v > 10 -> 0
      v > 5 -> 1
      v > 1 -> 5
      true -> 10
    end
  end
end
