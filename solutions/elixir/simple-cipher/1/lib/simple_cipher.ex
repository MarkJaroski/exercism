defmodule SimpleCipher do
  @doc """
  Given a `plaintext` and `key`, encode each character of the `plaintext` by
  shifting it by the corresponding letter in the alphabet shifted by the number
  of letters represented by the `key` character, repeating the `key` if it is
  shorter than the `plaintext`.

  For example, for the letter 'd', the alphabet is rotated to become:

  defghijklmnopqrstuvwxyzabc

  You would encode the `plaintext` by taking the current letter and mapping it
  to the letter in the same position in this rotated alphabet.

  abcdefghijklmnopqrstuvwxyz
  defghijklmnopqrstuvwxyzabc

  "a" becomes "d", "t" becomes "w", etc...

  Each letter in the `plaintext` will be encoded with the alphabet of the `key`
  character in the same position. If the `key` is shorter than the `plaintext`,
  repeat the `key`.

  Example:

  plaintext = "testing"
  key = "abc"

  The key should repeat to become the same length as the text, becoming
  "abcabca". If the key is longer than the text, only use as many letters of it
  as are necessary.
  """
  def encode(plaintext, key) do
    key = String.to_charlist(key)
    plaintext = String.to_charlist(plaintext)
    to_string(do_encode(plaintext, key))
  end

  defp do_encode(plaintext, key, i \\ 0, cyphertext \\ [])
  defp do_encode([], _, _, c), do: Enum.reverse(c)
  defp do_encode(p, k, i, c) when i == length(k), do: do_encode(p, k, 0, c)
  defp do_encode([h | t], k, i, c) do
    w = h + (Enum.at(k, i) - ?a)
    out = cond do
      w > ?z -> ?a + (w - (?z + 1))
      true -> w
    end
    do_encode(t, k, i + 1, [ out | c ])
  end

  @doc """
  Given a `ciphertext` and `key`, decode each character of the `ciphertext` by
  finding the corresponding letter in the alphabet shifted by the number of
  letters represented by the `key` character, repeating the `key` if it is
  shorter than the `ciphertext`.

  The same rules for key length and shifted alphabets apply as in `encode/2`,
  but you will go the opposite way, so "d" becomes "a", "w" becomes "t",
  etc..., depending on how much you shift the alphabet.
  """
  def decode(ciphertext, key) do
    key = String.to_charlist(key)
    cyphertext = String.to_charlist(ciphertext)
    do_decode(cyphertext, key)
  end

  defp do_decode(cyphertext, key, i \\ 0, plaintext \\ [])
  defp do_decode([], _, _, p), do: Enum.reverse(p)
  defp do_decode(c, k, i, p) when i == length(k), do: do_decode(c, k, 0, p)
  defp do_decode([h | t], k, i, p) do
    w = h - (Enum.at(k, i) - ?a)
    out = cond do
      w < ?a -> ?z - (?a - w) + 1
      true -> w
    end
    to_string(do_decode(t, k, i + 1, [ out | p ]))
  end

  @doc """
  Generate a random key of a given length. It should contain lowercase letters only.
  """
  def generate_key(length) do
    Range.to_list(1..length)
    |> Enum.reduce([], fn _, acc -> [Enum.random(?a..?z) | acc ] end)
    |> List.to_string()
  end
end
