defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, fn(x) -> x.price end)
  end

  def with_missing_price(inventory) do
    inventory
      |> Enum.reverse
      |> Enum.reduce([], fn x, acc -> 
      if x.price == nil, do: [x | acc], else: acc
    end) 
  end

  def update_names(inventory, old_word, new_word) do
    inventory
      |> Enum.map(fn x -> 
        if String.contains?(x.name, old_word) do
          new_name = String.replace(x.name, old_word, new_word)
          Map.replace(x, :name, new_name)
        else
          x
        end
      end)
  end

  def increase_quantity(item, count) do
    q = item.quantity_by_size 
    |> Enum.reduce(Map.new(), fn {k, v}, acc -> 
        Map.put(acc, k, v + count) 
      end)
    Map.replace(item, :quantity_by_size, q)
  end

  def total_quantity(item) do
    item.quantity_by_size
    |> Enum.reduce(0, fn {_, v}, acc -> acc + v end)
  end
end
