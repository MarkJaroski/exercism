defmodule LibraryFees do
  def datetime_from_string(string) do
    {:ok, ndt} = NaiveDateTime.from_iso8601(string)
    ndt
  end

  def before_noon?(datetime) do
    noon = NaiveDateTime.beginning_of_day(datetime)
      |> NaiveDateTime.add(12, :hour)
    NaiveDateTime.before?(datetime, noon)
  end

  def return_date(checkout_datetime) do
    days = if before_noon?(checkout_datetime), do: 28, else: 29
    NaiveDateTime.add(checkout_datetime, days, :day)
      |> NaiveDateTime.to_date()
  end

  def days_late(due_date, return_datetime) do
    return_date = NaiveDateTime.to_date(return_datetime)
    days = Date.diff(return_date, due_date)
    if days < 0, do: 0, else: days
  end

  def monday?(datetime) do
    1 == NaiveDateTime.to_date(datetime)
      |> Date.day_of_week
  end

  def calculate_late_fee(checkout, return, rate) do
    returndate = datetime_from_string(return)
    days = datetime_from_string(checkout)
      |> return_date
      |> days_late(returndate)
    if monday?(returndate), do: floor(days * (rate / 2)), else: days * rate
  end
end
