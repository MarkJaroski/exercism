defmodule House do
  @forms [ 
    %{
      :verb => "lay in",
      :noun=> "the house that Jack built."
    },
    %{
      :verb => "ate",
      :noun=> "the malt"
    },
    %{
      :verb => "killed",
      :noun=> "the rat"
    },
    %{
      :verb => "worried",
      :noun=> "the cat"
    },
    %{
      :verb => "tossed",
      :noun=> "the dog"
    },
    %{
      :verb => "milked",
      :noun=> "the cow with the crumpled horn"
    },
    %{
      :verb => "kissed",
      :noun=> "the maiden all forlorn"
    },
    %{
      :verb => "married",
      :noun=> "the man all tattered and torn"
    },
    %{
      :verb => "woke",
      :noun=> "the priest all shaven and shorn"
    },
    %{
      :verb => "kept",
      :noun=> "the rooster that crowed in the morn"
    },
    %{
      :verb => "belonged to",
      :noun=> "the farmer sowing his corn"
    },
    %{
      :verb => "",
      :noun=> "the horse and the hound and the horn"
    }
  ]
  @doc """
  Return verses of the nursery rhyme 'This is the House that Jack Built'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    start..stop
    |> Enum.reduce("", fn x, acc -> acc <> recite_verse(x - 1) <> "\n" end)
  end

  defp recite_verse(n) do
    n..0//-1
    |> Enum.reduce("", fn x, out -> out <> recite_line(x, n) end)
  end

  defp recite_line(line, verse) when verse == line do
    pair = Enum.at(@forms, line)
    "This is #{pair.noun}"
  end
  defp recite_line(line, _) do
    pair = Enum.at(@forms, line)
    " that #{pair.verb} #{pair.noun}"
  end

end
