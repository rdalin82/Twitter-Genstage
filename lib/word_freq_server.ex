defmodule Twitter.WordFreqServer do
  use GenServer

  @name Twitter.WordFreqServer

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: @name)
  end

  def init(%{}) do
    IO.puts "Word Freq Server Starting"
    map = %{}
    {:ok, map}
  end

  def words() do
    GenServer.call(__MODULE__, :words)
  end

  def handle_cast({:update, tweets}, state) do
    {:ok, stop_words} = File.open("assets/stopwordlist.csv", [:read],
      fn(file) -> IO.read(file, :all)
      |> String.split(", ", trim: true)
    end)
    list_tweets = String.downcase(tweets)
    |> String.split(" ")
    |> Stemmer.stem()
    list_tweets = Enum.reject(list_tweets, fn(word)
      -> stop_word?(stop_words, word)
    end)
    words_map = Enum.reduce(list_tweets, %{}, &update_count/2)
    new_state = Map.merge(state, words_map)
    {:noreply, new_state}
  end

  def handle_call(:words, _from, state) do
    File.write!("assets/tweets", Poison.encode!(state))
    {:reply, state, state}
  end

  #private
  def update_count(word, acc) do
    Map.update(acc, String.to_atom(word), 1, &(&1 + 1))
  end


  defp stop_word?(stop_words, word) do
    Enum.member?(stop_words, word)
  end

end
