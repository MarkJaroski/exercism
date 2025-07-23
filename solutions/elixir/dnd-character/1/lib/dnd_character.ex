defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    floor((score - 10) / 2)
  end

  @spec ability :: pos_integer()
  def ability do
    roll(4, 6) |> Enum.sort |> Enum.slice(1, 3) |> Enum.sum
  end

  @spec character :: t()
  def character do
    char = %DndCharacter{}
    |> Map.put(:strength, ability())
    |> Map.put(:dexterity, ability())
    |> Map.put(:constitution, ability())
    |> Map.put(:intelligence, ability())
    |> Map.put(:wisdom, ability())
    |> Map.put(:charisma, ability())

    char
    |> Map.put(:hitpoints, 10 + modifier(char.constitution))
  end

  defp roll(rolls, sides, acc \\ [])
  defp roll(0, _, acc), do: acc
  defp roll(rolls, sides, acc) do
    roll(rolls - 1, sides, [Enum.random(1..sides) | acc])
  end

end
