defmodule ResistorColorTrio do
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
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label(colors) do
    exp = @colours[Enum.at(colors, 2)]
    ohms = value(colors) * 10 ** exp
    cond do
      ohms == 0 -> {ohms, :ohms}
      rem(ohms, 10 ** 9) == 0 -> {div(ohms, 10 ** 9), :gigaohms}
      rem(ohms, 10 ** 6) == 0 -> {div(ohms, 10 ** 6), :megaohms}
      rem(ohms, 10 ** 3) == 0 -> {div(ohms, 10 ** 3), :kiloohms}
      true -> {ohms, :ohms}
    end
  end

  defp value(colors) do
    colors
    |> Enum.take(2)
    |> Enum.map(& @colours[&1])
    |> Integer.undigits()
  end

end
