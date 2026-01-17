defmodule GuessingGame do

  @doc """
    s is the secret_number that the user is trying to guess
    g is the user's guess (if supplied)
  """
  def compare(s, g \\ :no_guess)
  def compare(_s, g) when g == :no_guess, do: "Make a guess"
  def compare(s, g) when s == g, do: "Correct"
  def compare(s, g) when s == g + 1, do: "So close"
  def compare(s, g) when s == g - 1, do: "So close"
  def compare(s, g) when s < g, do: "Too high"
  def compare(s, g) when s > g, do: "Too low"
end
