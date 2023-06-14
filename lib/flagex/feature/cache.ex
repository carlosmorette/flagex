defmodule Flagex.Feature.Cache do
  use GenServer

  alias Flagex.Feature.Schema

  @await_time 15_000 * 60

  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(_args) do
    Process.send_after(__MODULE__, :pull_features, @await_time)
    {:ok, get_all_features()}
  end

  @impl true
  def handle_info(:pull_features, _state) do
    {:noreply, get_all_features()}
  end

  @impl true
  def handle_call({:enabled?, name}, _from, state) do
    cond do
      !Map.has_key?(state, name) ->
        {result, state} = cache_then_check_by_database(state, name)
        {:reply, result, state}

      Map.has_key?(state, name) ->
        {:reply, Map.get(state, name), state}
    end
  end

  def enable?(name) do
    GenServer.call(__MODULE__, {:enabled?, name})
  end

  ## Utils
  defp cache_then_check_by_database(state, name) do
    case Schema.find(name: name) do
      %Schema{enabled: enabled} ->
        {enabled, Map.put(state, name, enabled)}

      nil ->
        {false, state}
    end
  end

  def get_all_features do
    Schema.get_all()
    |> Enum.map(&{&1.name, &1.enabled})
    |> Enum.into(%{})
  end
end
