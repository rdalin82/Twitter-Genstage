defmodule Twitter.ConsumerServer do
  use GenServer

  @name Twitter.ConsumerServer

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: @name)
  end

  def stats() do
    GenServer.call(__MODULE__, :stats)
  end

  def init(%{}) do
    IO.puts "Sentiment Server starting"
    map = %{}
    state = Map.put_new(map, :sentiment, 0)
    {:ok, state}
  end

  def handle_cast({:update, tweets}, state) do
    new_value = Enum.to_list(tweets)
    |> Enum.map(fn(tweet)-> Sentient.analyze(tweet) end)
    |> Enum.sum()
    old_value = Map.get(state, :sentiment, 0)
    new_state = Map.put(state, :sentiment, new_value)
    {:noreply, new_state}
  end

  def handle_call(:stats, _from, state) do
    {:reply, state, state}
  end
end
