defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    @planetary_classes
    |> Enum.random()
  end

  def random_ship_registry_number() do
    num = Enum.to_list(1000..9999)
    |> Enum.random()
    "NCC-#{num}"
  end

  def random_stardate() do
    :rand.uniform() * 1000 + 41000
  end

  def format_stardate(stardate) do
    st = :io_lib.format("~.1f", [stardate])
    "#{st}"
  end
end
