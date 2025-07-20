defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) when shift >= 0, do: do_rotate(text, shift)
  def rotate(text, shift) when shift < 0 do
    do_rotate(text, shift + 26)
  end

  def do_rotate(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(&add(&1, shift))
    |> to_string()
  end

  defp add(c, shift) when c >= ?a and c <= ?z do
    rem(c - ?a + shift, 26) + ?a
  end
  defp add(c, shift) when c >= ?A and c <= ?Z do
    rem(c - ?A + shift, 26) + ?A
  end
  defp add(c, _shift), do: c

end
