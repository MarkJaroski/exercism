# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> %{idx: 0, plots: []} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn state -> state.plots end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn state -> 
      i = Map.get(state, :idx) + 1
      plot = %Plot{plot_id: i, registered_to: register_to}
      plots = state.plots
      state = state
      |> Map.replace(:idx, i)
      |> Map.replace(:plots, [plot | plots])
      {plot, state}
    end)
  end

  def release(pid, plot_id) do
    Agent.get_and_update(pid, fn state -> 
      plots = state.plots
        |> Enum.filter(fn x -> x.plot_id != plot_id end)
      state = state
      |> Map.replace(:plots, plots)
      {:ok, state}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn state -> state.plots end)
    |> Enum.filter(fn x -> x.plot_id == plot_id end)
    |> List.first()
    || {:not_found, "plot is unregistered"}
  end
end
