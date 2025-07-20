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
        upper?(c) and upper?(n) -> n
        lower?(c) and lower?(n) -> n
        upper?(c) and n > ?Z -> (n - ?Z) + (?A - 1)
        upper?(c) and n < ?A -> (?Z + 1) - (?A - n)
        lower?(c) and n > ?z -> (n - ?z) + (?a - 1)
        lower?(c) and n < ?a -> (?z + 1) - (?a - n)
        true -> c
      end
    end)
    |> to_string()
  end

  defp upper?(c) do
    c >= ?A and c <= ?Z
  end

  defp lower?(c) do
    c >= ?a and c <= ?z
  end
end
