defmodule Say do
  @tens %{
    2 => "twenty",
    3 => "thirty",
    4 => "forty",
    5 => "fifty",
    6 => "sixty",
    7 => "seventy",
    8 => "eighty",
    9 => "ninety"
  }
  @simple %{
    0 => "",
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",
  }
  @places ~w[thousand million billion]
  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(n) when n < 0, do: {:error, "number is out of range"}
  def in_english(n) when n > 999_999_999_999, do: {:error, "number is out of range"}
  def in_english(0), do: {:ok, "zero"}
  def in_english(n) do 
    {:ok, do_in_english(n) 
          |> Enum.filter(fn c -> c != "" end) 
          |> Enum.join(" ")
    }
  end

  defp do_in_english(n) when n > 999 do
    [h | t] = Integer.digits(n)
    |> Enum.reverse()
    |> Enum.chunk_every(3)
    |> Enum.map(fn l -> 
      Enum.reverse(l) |> Integer.undigits()
    end)
    
    [t, @places]
    |> Enum.zip_reduce([do_in_english(h)], fn [n, p], acc ->
      case n do
        0 -> acc
        _ -> [ do_in_english(n) | [p | acc] ]
      end
    end)
    |> List.flatten()
  end

  defp do_in_english(n) when n > 99 do
    [h | t] = Integer.digits(n)
    t = Integer.undigits(t)
    [ @simple[h] | [ "hundred" | do_in_english(t) ]]
  end

  defp do_in_english(n) when n > 19 do
    [h | t ] = Integer.digits(n)
    t = Integer.undigits(t)
    case t do
      0 -> [ @tens[h] ]
      _ -> [ @tens[h] <> "-" <> @simple[t] ]
    end
  end

  defp do_in_english(n), do: [@simple[n]]

end
