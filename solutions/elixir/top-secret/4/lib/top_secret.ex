defmodule TopSecret do
  def to_ast(string) do
    {:ok, ast} = Code.string_to_quoted(string)
    ast
  end

  def decode_secret_message_part({op, _, [{_, _, nil} | _]} = node, acc) when op in [:def, :defp] do
    {node, [""| acc]}
  end
  def decode_secret_message_part({_, _, [{:when, _, [{f, _, args} | _]} | _]} = node, acc) do
    fname = to_charlist(f) |> Enum.take(Enum.count(args)) |> to_string
    {node, [fname | acc]}
  end
  def decode_secret_message_part({op, _, [{f, _, args} | _]} = node, acc) when op in [:def, :defp] do
    fname = to_charlist(f) |> Enum.take(Enum.count(args)) |> to_string
    {node, [fname | acc]}
  end
  def decode_secret_message_part(ast, acc), do: {ast, acc}

  def decode_secret_message(string) do
    to_ast(string)
    |> Macro.prewalk([], &decode_secret_message_part/2) 
    |> elem(1)
    |> Enum.reduce("", &<>/2)
  end

end
