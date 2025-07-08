defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    pid = spawn_link(fn -> calculator.(input) end)
    %{input: input, pid: pid}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(results, input, :ok)
      {:EXIT, ^pid, _} -> Map.put(results, input, :error)
    after
      100 -> Map.put(results, input, :timeout)
    end
  end


  def reliability_check(calculator, inputs) do
    was = Process.flag(:trap_exit, true)
    prox = Enum.map(inputs, fn i -> 
      start_reliability_check(calculator, i)
    end)
    res = Enum.reduce(prox, Map.new(), fn proc, acc ->
      await_reliability_check_result(proc, acc)
    end)
    Process.flag(:trap_exit, was) 
    res
  end

  def correctness_check(calculator, inputs) do
    inputs
    |> Enum.map(fn i -> Task.async(fn -> calculator.(i) end) end)
    |> Enum.map(fn t -> Task.await(t, 100) end)
  end
end
