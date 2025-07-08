defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """
  @phi 1.618033989

  def generate(count) when not is_integer(count) do
    raise ArgumentError, "count must be specified as an integer >= 1"
  end
  def generate(count) when count < 1 do
    raise ArgumentError, "count must be specified as an integer >= 1"
  end
  def generate(1) do
    [2]
  end
  def generate(2) do
    [2, 1]
  end
  def generate(count) do
    [2| [1 | Stream.from_index(fn x -> 
      round(@phi ** x)
    end) |> Enum.slice(2..(count - 1))]]
  end
end
