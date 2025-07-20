defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(fn c -> 
      n = c + shift
      cond do
        is_upper?(c) and is_upper?(n) -> n
        is_lower?(c) and is_lower?(n) -> n
        is_upper?(c) and n > ?Z -> (n - ?Z) + (?A - 1)
        is_upper?(c) and n < ?A -> (?Z + 1) - (?A - n)
        is_lower?(c) and n > ?z -> (n - ?z) + (?a - 1)
        is_lower?(c) and n < ?a -> (?z + 1) - (?a - n)
        true -> c
      end
    end)
    |> to_string()
  end

  defp is_upper?(c) do
    c >= ?A and c <= ?Z
  end

  defp is_lower?(c) do
    c >= ?a and c <= ?z
  end
end
