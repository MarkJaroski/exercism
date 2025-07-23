defmodule BottleSong do
  @cardinal ~w/no One Two Three Four Five Six Seven Eight Nine Ten/
  @moduledoc """
  Handles lyrics of the popular children song: Ten Green Bottles
  """

  @spec recite(pos_integer, pos_integer) :: String.t()
  def recite(_, 0), do: ""
  def recite(start_bottle, take_down) do
    do_recite(start_bottle, take_down)
  end

  defp do_recite(start_bottle, take_down, out \\ "")
  defp do_recite(_, 0, out), do: out
  defp do_recite(start_bottle, take_down, out) do
    before = Enum.at(@cardinal, start_bottle)
    remaining = Enum.at(@cardinal, start_bottle - 1) |> String.downcase()
    s = if start_bottle == 1, do: "", else: "s"
    ls = if start_bottle == 2, do: "", else: "s"
    out = out <> String.trim("""
      #{before} green bottle#{s} hanging on the wall,
      #{before} green bottle#{s} hanging on the wall,
      And if one green bottle should accidentally fall,
      There'll be #{remaining} green bottle#{ls} hanging on the wall.
      """)
    out = out <> if take_down > 1, do: "\n\n", else: ""
    do_recite(start_bottle - 1, take_down - 1, out)
  end

end
