defmodule ComplexNumbers do
  @e 2.718281828459045
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {number, number}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: number
  def real(a) do
    elem(a, 0)
  end

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: number
  def imaginary(a) do
    elem(a, 1)
  end

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(a :: complex | number, b :: complex | number) :: complex
  def mul(a, b) when is_tuple(a) and is_number(b), do: mul(a, {b, 0})
  def mul(a, b) when is_tuple(b) and is_number(a), do: mul(b, {a, 0})
  def mul({ar, ai}, {br, bi}) do
    {ar * br - ai * bi, ai * br + ar * bi}
  end

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(a :: complex | number, b :: complex | number) :: complex
  def add(a, b) when is_tuple(a) and is_number(b), do: add(a, {b, 0})
  def add(a, b) when is_tuple(b) and is_number(a), do: add(b, {a, 0})
  def add({a, b}, {c, d}) do
    {a + c, b + d}
  end

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(a :: complex | number, b :: complex | number) :: complex
  def sub(a, b) when is_tuple(a) and is_number(b), do: sub(a, {b, 0})
  def sub(a, b) when is_tuple(b) and is_number(a), do: sub({a, 0}, b)
  def sub({ar, ai}, {br, bi}) do
    {ar - br, ai - bi}
  end

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(a :: complex | number, b :: complex | number) :: complex
  def div(a, b), do: do_div(a, b)
  defp do_div({r, i}, n) when is_number(n), do: do_div({r, i}, {n, 0})
  defp do_div(n, {r, i}) when is_number(n), do: do_div({n, 0}, {r, i})
  defp do_div({ar, ai}, {br, bi}) do
    {(ar * br + ai * bi) / (br ** 2 + bi ** 2),
    (ai * br - ar * bi) / (br ** 2 + bi ** 2)}
  end

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: number
  def abs({ar, ai}) do
    :math.sqrt(ar ** 2 + ai ** 2)
  end

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate({ar, ai}) do
    {ar, ai * -1}
  end

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp({ar, ai}) do
    {@e ** ar * :math.cos(ai), @e ** ar * :math.sin(ai)}
  end
end
