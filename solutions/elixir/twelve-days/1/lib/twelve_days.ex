defmodule TwelveDays do
  @gifts [
      "a Partridge in a Pear Tree.",
      "two Turtle Doves",
      "three French Hens",
      "four Calling Birds",
      "five Gold Rings",
      "six Geese-a-Laying",
      "seven Swans-a-Swimming",
      "eight Maids-a-Milking",
      "nine Ladies Dancing",
      "ten Lords-a-Leaping",
      "eleven Pipers Piping",
      "twelve Drummers Drumming"
    ]
  @ordinal ~w[first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth]
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(n) do
    ord = Enum.at(@ordinal, n - 1)
    "On the #{ord} day of Christmas my true love gave to me: " <> gifts(n - 1)
  end

  defp gifts(0), do: Enum.at(@gifts, 0)
  defp gifts(1) do
    Enum.at(@gifts, 1) <> ", and " <> gifts(0)
  end
  defp gifts(n) do
    Enum.at(@gifts, n) <> ", " <> gifts(n - 1)
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    Range.new(ending_verse, starting_verse, -1)
    |> Range.to_list()
    |> Enum.reduce([], fn n, acc -> [ verse(n) | acc ] end)
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end
end
