defmodule TakeANumber do

  def start() do
    spawn(fn ->
      loop(0) 
    end)
  end

  defp loop(n) do
    receive do
      :stop -> nil
      {:report_state, pid} -> ticket(pid, n)
      {:take_a_number, pid} -> ticket(pid, n + 1)
      _ -> loop(n)
    end
  end

  defp ticket(pid, n) do
    send(pid, n)
    loop(n)
  end

end
