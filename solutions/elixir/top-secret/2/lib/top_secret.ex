defmodule TopSecret do
  def to_ast(string) do
    {:ok, ast} = Code.string_to_quoted(string)
    ast
  end

  def decode_secret_message_part({:def, _, args} = node, acc) do
    {node, do_decode(args, acc)}
  end
  def decode_secret_message_part({:defp, _, args} = node, acc) do
    {node, do_decode(args, acc)}
  end
  def decode_secret_message_part(ast, acc), do: {ast, acc}
  
  defp do_decode(args, acc) do
    {name, _, fargs} = List.first(args)
    if name == :when do
      do_decode(fargs, acc)
    else
      arity = get_arity_from_args(fargs)
      fname = String.slice(Atom.to_string(name), 0, arity)
      [fname | acc]
    end
  end

  defp get_arity_from_args(nil), do: 0
  defp get_arity_from_args(args), do: length(args)

  def decode_secret_message(string) do
    to_ast(string)
    |> Macro.prewalk([], &decode_secret_message_part/2) 
    |> elem(1)
    |> Enum.reduce("", fn x, acc -> x <> acc end)
  end

end
