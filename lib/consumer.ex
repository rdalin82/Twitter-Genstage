alias Experimental.GenStage

defmodule Twitter.Consumer do
	use GenStage

	def start_link do
		GenStage.start_link(__MODULE__, [])
	end

	def init(tweets) do
		IO.inspect [self, "consumer"]
		{:consumer, tweets, subscribe_to: [{Twitter.Producer, max_demand: 1}]}
	end

	def handle_events(events, _from, tweets) do
		new_tweets = events |> Enum.map(fn e -> e.text end)
		new_tweets |> Enum.each(fn t -> IO.inspect([self,t]) end)
		
		IO.inspect [self,"sleeping for 10s"]
		:timer.sleep(10_000)
		IO.inspect [self,"awake"]

		{:noreply, [], nil}
	end

end