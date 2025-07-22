defmodule Atbash do

  @plain  "abcdefghijklmnopqrstuvwxyz"
  @cipher "zyxwvutsrqponmlkjihgfedcba"

  @doc """
  Encode a given plaintext to the corresponding ciphertext


  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    enc = enc_map()
    plaintext
    |> String.downcase()
    |> String.graphemes()
    |> Enum.reduce([], fn x, acc -> 
      cond do
        Regex.match?(~r/[a-z]/, x) -> [Map.get(enc, x) | acc]
        Regex.match?(~r/[0-9]/, x) -> [x | acc]
        true -> acc
      end
    end)
    |> Enum.reverse()
    |> Enum.chunk_every(5)
    |> Enum.join(" ")
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    dec = dec_map()
    cipher
    |> String.graphemes()
    |> Enum.reduce([], fn x, acc -> 
      cond do
        x == " " -> acc
        Regex.match?(~r/[0-9]/, x) -> [x | acc]
        true -> [Map.get(dec, x) | acc]
      end
    end)
    |> Enum.reverse()
    |> Enum.join()
  end

  defp enc_map() do
    Enum.zip([String.graphemes(@plain), String.graphemes(@cipher)])
    |> Map.new()
  end
  
  defp dec_map() do
    Enum.zip([String.graphemes(@cipher), String.graphemes(@plain)])
    |> Map.new()
  end

end
