defmodule Lasagna do

  def expected_minutes_in_oven(), do: 40

  def remaining_minutes_in_oven(t) do
    expected_minutes_in_oven() - t
  end

  def preparation_time_in_minutes(n_layers) do
    n_layers * 2
  end

  def total_time_in_minutes(n_layers, time) do
    preparation_time_in_minutes(n_layers) + time
  end

  def alarm do
    "Ding!"
  end
end
