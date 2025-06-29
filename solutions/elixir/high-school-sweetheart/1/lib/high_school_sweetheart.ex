defmodule HighSchoolSweetheart do
  def first_letter(name) do
    String.trim(name)
      |> String.first()
  end

  def initial(name) do
    first_letter(name) <> "."
      |> String.upcase()
  end

  def initials(full_name) do
    String.split(full_name, " ")
      |> Enum.map(fn(x) -> initial(x) end)
      |> Enum.join(" ")
  end

  def pair(full_name1, full_name2) do
    # ❤-------------------❤
    # |  X. X.  +  X. X.  |
    # ❤-------------------❤
    i1 = initials(full_name1)
    i2 = initials(full_name2)
    """
    ❤-------------------❤
    |  #{i1}  +  #{i2}  |
    ❤-------------------❤
    """
  end
end
