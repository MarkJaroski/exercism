defmodule Acronym do
  @moduledoc """
    Acronym generation tools
  """
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.replace(~r/[_]/, "")
    |> String.split(~r/[\s-]/)
    |> Enum.reduce("", fn w, acc -> 
        if w == "" do
          acc
        else
          acc <> String.first(w) |> String.upcase()
        end
      end)
  end
end
