defmodule HighScore do

  @default_init_score 0

  def new(), do: %{}

  def add_player(scores, name, score \\ @default_init_score) do
    Map.put(scores, name, score)
  end

  def remove_player(scores, name) do
    Map.delete(scores, name)
  end

  def reset_score(scores, name) do
    Map.put(scores, name, @default_init_score)
  end

  def update_score(scores, name, score) do
    cur = Map.get(scores, name)
    if cur do
      Map.put(scores, name, score + cur)
    else
      Map.put(scores, name, score)
    end
  end

  def get_players(scores) do
    Map.keys(scores)
  end
end
