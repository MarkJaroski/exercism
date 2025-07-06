defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defprotocol Edible do
    def eat(item, character)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(_, c) do
      health = c.health + 5
      {nil, Map.replace(c, :health, health)}
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(i, c) do
      mana = c.mana + i.strength
      {%EmptyBottle{}, Map.replace(c, :mana, mana)}
    end
  end

  defimpl Edible, for: Poison do
    def eat(_, c) do
      {%EmptyBottle{}, Map.replace(c, :health, 0)}
    end
  end

end
