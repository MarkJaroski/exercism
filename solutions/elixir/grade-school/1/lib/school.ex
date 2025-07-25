defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @type school :: any()

  @doc """
  Create a new, empty school.
  """
  @spec new() :: school
  def new() do
    1..8
    |> Enum.reduce(Map.new(), fn x, sch -> Map.put(sch, x, []) end)
  end

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(school, String.t(), integer) :: {:ok | :error, school}
  def add(school, name, grade) do
    g = Map.get(school, grade)
    if Enum.member?(School.roster(school), name) do 
      {:error, school}
    else
      {:ok, Map.replace(school, grade, [name | g])}
    end
  end

  @doc """
  Return the names of the students in a particular grade, sorted alphabetically.
  """
  @spec grade(school, integer) :: [String.t()]
  def grade(school, grade) do
    Map.get(school, grade) |> Enum.sort()
  end

  @doc """
  Return the names of all the students in the school sorted by grade and name.
  """
  @spec roster(school) :: [String.t()]
  def roster(school) do
    school
    |> Map.keys()
    |> Enum.reduce([], fn grade, acc -> 
      Enum.concat(acc, grade(school, grade))
    end)
  end
end
