alias Gibran.Tokeniser

defmodule Twitter.Consumer do
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, [])
  end

  def init(tweets) do
    IO.puts "consumer"
    {:consumer, tweets, subscribe_to: [{Twitter.Producer, max_demand: 200, min_demand: 150}]}
  end

  def handle_events(events, _from, tweets) do
    new_tweets = events |> Enum.map(fn e -> e.text end)
    # new_tweets |> Enum.each(fn t -> IO.inspect([self,t]) end)

    IO.puts "sleeping for 10s"
    :timer.sleep(10_000)
    IO.puts "awake"
    string_tweets = Enum.join(new_tweets, " ") |> Tokeniser.tokenise() |>  Enum.join(" ")
    GenServer.cast(Twitter.WordFreqServer, {:update, string_tweets})
    GenServer.cast(Twitter.ConsumerServer, {:update, new_tweets})
    {:noreply, [], nil}
  end

end
