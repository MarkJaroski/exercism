defmodule DNA do

  @nibble 4

  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0b0000
      ?A  -> 0b0001
      ?C  -> 0b0010
      ?G  -> 0b0100
      ?T  -> 0b1000
      _ -> nil
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0000 -> ?\s
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
      _ -> nil
    end
  end

  def encode(dna), do: do_encode(dna, <<>>)

  defp do_encode(~c"", bits), do: bits
  defp do_encode([ head | tail], bits) do
    do_encode(tail, << bits::bitstring, encode_nucleotide(head)::4 >>)
  end

  def decode(dna), do: do_decode(dna, ~c"")
  defp do_decode(<<>>, chars), do: chars
  defp do_decode(<< head::@nibble, tail::bitstring >>, chars) do
    do_decode(tail, chars ++ [decode_nucleotide(head)])
  end
end
