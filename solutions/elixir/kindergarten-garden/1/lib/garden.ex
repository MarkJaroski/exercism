defmodule Garden do
  @plantmap %{
    "G" => :grass,
    "C" => :clover,
    "R" => :radishes,
    "V" => :violets
  }

  @names [:alice, :bob, :charlie, :david, :eve, :fred, :ginny, :harriet, :ileana, :joseph, :kincaid, :larry]

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @names)
  def info(info_string, student_names) do
    student_names = student_names |> Enum.sort()
    Enum.reduce(student_names, %{}, fn name, acc -> 
      plants = info_string 
      |> String.split("\n")
      |> Enum.reduce("", fn s, out -> 
        i = Enum.find_index(student_names, fn x -> name == x end)
        out <> String.slice(s, i * 2, 2)
      end)
      |> String.graphemes()
      |> Enum.map(fn x -> Map.get(@plantmap, x) end)
      |> List.to_tuple()

      Map.put(acc, name, plants)
    end)
  end
end
