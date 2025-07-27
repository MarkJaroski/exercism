defmodule Matrix do
  defstruct matrix: nil

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    %Matrix{ matrix: input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line -> 
      line
      |> String.trim()
      |> String.split() 
      |> Enum.map(&String.to_integer/1)
    end) }
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(matrix) do
    matrix.matrix
    |> Enum.map(fn row -> Enum.join(row, " ") end)
    |> Enum.join("\n")
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(matrix) do
    matrix.matrix
  end

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(matrix, index) do
    rows(matrix)
    |> Enum.at(index - 1)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.

  This is a bit more convoluted than a solution using the row and column
  indexes in composition would be, but my goal was pretend that those
  functions don't exist, and to use recursion instead.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(matrix) do
    rows(matrix)
    |> rows_to_cols()
    |> Enum.map(&Enum.reverse/1)
    |> Enum.reverse()
  end

  defp rows_to_cols(rows, cols \\ [])
  defp rows_to_cols([], cols), do: cols
  defp rows_to_cols(rows, cols) do
    out = rows
    |> Enum.reduce(%{:col => [], :rows => []}, fn row, acc ->
      [h | t] = row
      cond do
      t == [] -> acc
        |> Map.replace(:col, [h | acc.col])
      true -> acc 
        |> Map.replace(:col, [h | acc.col])
        |> Map.replace(:rows, [t | acc.rows])
      end
    end)

    rows_to_cols(Enum.reverse(out.rows), [out.col | cols])
  end


  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(matrix, index) do
    columns(matrix)
    |> Enum.at(index - 1)
  end
end
