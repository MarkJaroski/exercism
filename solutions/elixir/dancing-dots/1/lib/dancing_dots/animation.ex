defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts()) :: {:ok, opts()} | {:error, :error}
  @callback handle_frame(dot(), frame_number(), opts()) :: dot()

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end

end

defmodule DancingDots.Flicker do
  # Please implement the module
  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(dot, f, _) when rem(f, 4) == 0 do
    Map.replace(dot, :opacity, dot.opacity / 2)
  end
  def handle_frame(dot, _, _), do: dot
end

defmodule DancingDots.Zoom do
  # Please implement the module
  use DancingDots.Animation

  @impl DancingDots.Animation
  def init(opt) do 
    cond do
      Keyword.has_key?(opt, :velocity) and is_number(opt[:velocity]) -> {:ok, opt}
      true -> {:error, "The :velocity option is required, and its value must be a number. Got: #{inspect(opt[:velocity])}"}
    end
  end

  @impl DancingDots.Animation
  def handle_frame(dot, n, opt) do
    v = opt[:velocity]
    r = dot.radius + ((n - 1) * v)
    Map.replace(dot, :radius, r)
  end
end
