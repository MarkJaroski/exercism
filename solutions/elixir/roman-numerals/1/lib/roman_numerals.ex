defmodule RomanNumerals do
  @digits %{ 
            1 => "i",
            2 => "ii",
            3 => "iii",
            4 => "iv",
            5 => "v",
            6 => "vi",
            7 => "vii",
            8 => "viii",
            9 => "ix"
           }
  @ranks %{ 
      0 => %{
          "i" => "I",
          "v" => "V",
          "x" => "X"
          },
      1 => %{
          "i" => "X",
          "v" => "L",
          "x" => "C"
          },  
      2 => %{
          "i" => "C",
          "v" => "D",
          "x" => "M"
          },
      3 => %{
          "i" => "M",
          "v" => "Ṽ",
          "x" => "x̄"
          }
      }

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(n) do
    Integer.digits(n)
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {n, i} -> digit(n, i) end)
    |> Enum.reverse()
    |> Enum.join()
  end

  defp digit(0, _), do: ""
  defp digit(n, rank) when n > 0 and n < 10 do
    @digits[n]
    |> String.graphemes()
    |> Enum.map(fn s -> @ranks[rank][s] end)
    |> Enum.join()
  end

end
