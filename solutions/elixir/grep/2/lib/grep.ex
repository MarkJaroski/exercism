defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    n_mode = Enum.member?(flags, "-n")
    l_mode = Enum.member?(flags, "-l")
    i_mode = Enum.member?(flags, "-i")
    v_mode = Enum.member?(flags, "-v")
    x_mode = Enum.member?(flags, "-x")
    m_mode = Enum.count(files) > 1

    matches = files 
    |> Enum.reduce([], fn f, acc -> 
      lines = File.stream!(f, :line)
      |> Enum.with_index(1)
      |> Enum.filter(fn {line, _i} ->
        cf = if i_mode, do: "i", else: ""
        pattern = if x_mode, do: "^#{pattern}$", else: pattern
        found = String.match?(line, Regex.compile!(pattern, cf))
        if v_mode, do: !found, else: found
      end)
      |> Enum.reduce([], fn {line, i}, macc -> 
        [{f, line, i} | macc]
      end)

      Enum.concat(lines, acc)
    end)

    cond do
      l_mode -> matching_files(matches)
      true -> matching_lines(matches, n_mode, m_mode)
    end
  end

  defp matching_files(matches) do
    matches
    |> Enum.reduce([""], fn {f, _, _}, acc -> [f | acc] end)
    |> Enum.uniq()
    |> Enum.join("\n")
  end

  defp matching_lines(matches, n_mode, m_mode) do
    matches
    |> Enum.reduce([], fn {f, l, i}, acc -> 
      l = if n_mode, do: to_string(i) <> ":" <> l, else: l
      l = if m_mode, do: f <> ":" <> l, else: l
      [l | acc] 
    end)
    |> Enum.join()
  end


end
