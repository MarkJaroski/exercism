defmodule TakeANumberDeluxe do
  # Client API
  use GenServer

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg)
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    GenServer.call(machine, :report_state)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    GenServer.call(machine, :queue_new_number)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    GenServer.call(machine, {:serve_next_queued_number, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.cast(machine, :reset_state)
  end

  # Server callbacks
  @impl GenServer
  def init(init_arg) do
    min = init_arg[:min_number]
    max = init_arg[:max_number]
    timeout = init_arg[:auto_shutdown_timeout] || :infinity
    TakeANumberDeluxe.State.new(min, max, timeout)
    |> case do
      {:ok, state} -> {:ok, state, timeout}
      {:error, err} -> {:stop, err}
    end
  end

  @impl GenServer
  def handle_call(:report_state, _from, state) do
    timeout = state.auto_shutdown_timeout
    {:reply, state, state, timeout}
  end

  @impl GenServer
  def handle_call(:queue_new_number, _from, state) do
    timeout = state.auto_shutdown_timeout
    TakeANumberDeluxe.State.queue_new_number(state)
    |> case do
      {:ok, n, new} -> {:reply, {:ok, n}, new, timeout}
      {:error, err} -> {:reply, {:error, err}, state, timeout}
    end
  end

  @impl GenServer
  def handle_call({:serve_next_queued_number, pri}, _from, state) do
    timeout = state.auto_shutdown_timeout
    TakeANumberDeluxe.State.serve_next_queued_number(state, pri)
    |> case do
      {:ok, next, new} -> {:reply, {:ok, next}, new, timeout}
      {:error, err} -> {:reply, {:error, err}, state, timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset_state, state) do
    min = state.min_number
    max = state.max_number
    timeout = state.auto_shutdown_timeout
    TakeANumberDeluxe.State.new(min, max, timeout)
    |> case do
      {:ok, new} -> {:noreply, new, timeout}
    end
  end

  @impl GenServer
  def handle_info(:timeout, state) do
    {:stop, :normal, state}
  end

  @impl GenServer
  def handle_info(_, s), do: {:noreply, s, s.auto_shutdown_timeout}

end
