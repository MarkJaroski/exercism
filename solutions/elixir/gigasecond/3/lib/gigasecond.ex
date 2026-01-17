defmodule Gigasecond do
  # alias DialyxirVendored.Warnings.MapUpdate
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from(dt) do
    NaiveDateTime.from_erl!(dt)
    |> NaiveDateTime.add(1000 * 1000 * 1000)
    |> NaiveDateTime.to_erl()
  end
end
