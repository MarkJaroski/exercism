defmodule ResistorColorDuo do
  @colours [
      black:  0,
      brown:  1,
      red:    2,
      orange: 3,
      yellow: 4,
      green:  5,
      blue:   6,
      violet: 7,
      grey:   8,
      white:  9
    ]
  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value(colors) do
    colors
    |> Enum.take(2)
    |> Enum.reverse()
    |> Enum.map(&code/1)
    |> Enum.with_index()
    |> Enum.reduce(0, fn {n, i}, acc ->
      acc + n * 10 ** i
    end)
  end

  defp code(color) do
    Keyword.get(@colours, color)
  end

end
