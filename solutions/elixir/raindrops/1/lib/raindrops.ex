defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    do_pling(number)
    |> do_plang(number)
    |> do_plong(number)
    |> do_number(number)
  end

  defp do_pling(n) when rem(n, 3) == 0, do: "Pling"
  defp do_pling(_), do: ""

  defp do_plang(out, n) when rem(n, 5) == 0, do: out <> "Plang"
  defp do_plang(out, _), do: out

  defp do_plong(out, n) when rem(n, 7) == 0, do: out <> "Plong"
  defp do_plong(out, _), do: out

  defp do_number("", n), do: "#{n}"
  defp do_number(out, _), do: out

end
