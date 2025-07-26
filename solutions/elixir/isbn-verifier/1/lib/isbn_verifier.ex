defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    cond do
      String.match?(isbn, ~r/^[0-9-]+X?$/) -> to_list(isbn) |> do_validate()
      true -> false
    end
  end

  defp to_list(isbn) do
    isbn
    |> String.graphemes()
    |> Enum.filter(fn c -> c != "-" end)
    |> Enum.map(fn c -> 
      case c do
        "X" -> 10
        _ -> String.to_integer(c)
      end
    end)
  end

  defp do_validate(isbn) when length(isbn) != 10, do: false
  defp do_validate(isbn) do
    isbn
    |> epsilon() 
    |> Integer.mod(11) == 0
  end

  defp epsilon(isbn, sum \\ 0)
  defp epsilon([], sum), do: sum
  defp epsilon([h | t] = isbn, sum) do
    epsilon(t, (h * length(isbn)) + sum)
  end

  
end
