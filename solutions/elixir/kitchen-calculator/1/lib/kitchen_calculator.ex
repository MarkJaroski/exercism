defmodule KitchenCalculator do

  def get_volume({u, v}) when is_atom(u), do: v

  def to_milliliter({:cup, v}), do: {:milliliter, v * 240}
  def to_milliliter({:fluid_ounce, v}), do: {:milliliter, v * 30}
  def to_milliliter({:teaspoon, v}), do: {:milliliter, v * 5}
  def to_milliliter({:tablespoon, v}), do: {:milliliter, v * 15}
  def to_milliliter({_u, v}), do: {:milliliter, v}
  def to_milliliter(_), do: :error

  def from_milliliter({_, v}, u = :milliliter), do: {u, v}
  def from_milliliter({_, v}, u = :cup), do: {u, v / 240}
  def from_milliliter({_, v}, u = :fluid_ounce), do: {u, v / 30}
  def from_milliliter({_, v}, u = :teaspoon), do: {u, v / 5}
  def from_milliliter({_, v}, u = :tablespoon), do: {u, v / 15}

  def convert({o, v}, u) do
    to_milliliter({o, v})
      |> from_milliliter(u)
  end

end
