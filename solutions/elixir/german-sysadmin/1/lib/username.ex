defmodule Username do

  def sanitize(~c""), do: ~c""
  def sanitize([c | t]) do
    nc = case c do
      c when [c] == ~c"ä" -> ~c"ae"
      c when [c] == ~c"ö" -> ~c"oe"
      c when [c] == ~c"ü" -> ~c"ue"
      c when [c] == ~c"ß" -> ~c"ss"
      c when [c] == ~c"_" -> ~c"_"
      c when c >= ?a and c <= ?z -> c
      _ -> ~c""
    end
    List.to_charlist([nc | sanitize(t)])
  end
end
