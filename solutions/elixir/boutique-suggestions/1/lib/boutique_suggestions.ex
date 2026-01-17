defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    max = if Keyword.has_key?(options, :maximum_price) do
      options[:maximum_price]
    else
      100
    end
    for t <- tops, b <- bottoms,
          t.base_color != b.base_color
          and t.price + b.price <= max
          do 
      {t, b}
    end
  end
end
