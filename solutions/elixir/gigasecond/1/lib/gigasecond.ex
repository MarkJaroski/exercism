defmodule Gigasecond do
  alias DialyxirVendored.Warnings.MapUpdate
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    dt = NaiveDateTime.utc_now()
    |> Map.replace(:year, year)
    |> Map.replace(:month, month)
    |> Map.replace(:day, day)
    |> Map.replace(:hour, hours)
    |> Map.replace(:minute, minutes)
    |> Map.replace(:second, seconds)
    |> Map.replace!(:microsecond, {0, 6})
    |> NaiveDateTime.add(1000 * 1000 * 1000)
    {{dt.year, dt.month, dt.day}, {dt.hour, dt.minute, dt.second}}
  end
end
