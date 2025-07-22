defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(tree, data) do
    do_insert(tree, data)
  end

  # leave nodes
  defp do_insert(%{data: val, left: nil, right: _} = tree, data) when val >= data do
    Map.replace(tree, :left, new(data))
  end

  defp do_insert(%{data: val, left: _, right: nil} = tree, data) when val < data do
    Map.replace(tree, :right, new(data))
  end

  # branch nodes
  defp do_insert(%{data: val, left: branch, right: _} = tree, data) when val >= data do
    Map.replace(tree, :left, do_insert(branch, data))
  end

  defp do_insert(%{data: val, left: _, right: branch} = tree, data) when val < data do
    Map.replace(tree, :right, do_insert(branch, data))
  end


  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(tree) do
    do_walk(tree)
  end

  defp do_walk(%{data: val, left: nil, right: nil}), do: [ val ]

  defp do_walk(%{data: val, left: left, right: nil}) do
    Enum.concat([do_walk(left), [val]])
  end

  defp do_walk(%{data: val, left: nil, right: right}) do
    Enum.concat([[val], do_walk(right)])
  end

  defp do_walk(%{data: val, left: left, right: right}) do
    Enum.concat([do_walk(left), [val], do_walk(right)])
  end

end
