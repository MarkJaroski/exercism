defmodule NameBadge do
  def print(id, name, department) do
    badge = if department == nil do
      ["OWNER"]
    else
      [String.upcase(department)]
    end
    badge = [name | badge]
    badge = if id != nil do
      ["[#{id}]" | badge]
    else
      badge
    end
    Enum.join(badge, " - ")
  end
end
