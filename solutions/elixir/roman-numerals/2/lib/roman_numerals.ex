defmodule RomanNumerals do
  @digits [
            {1000, "M"},
             {900, "CM"},
             {500, "D"},
             {400, "CD"},
             {100, "C"},
              {90, "XC"},
              {50, "L"},
              {40, "XL"},
              {10, "X"},
               {9, "IX"},
               {5, "V"},
               {4, "IV"},
               {1, "I"}
           ]

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(0), do: ""
  def numeral(n) when n > 0 do
    {d, r} = Enum.find(@digits, fn {d, _} -> n >= d end)
    r <> numeral(n - d)
  end


end
