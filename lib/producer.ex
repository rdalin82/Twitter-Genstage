alias Experimental.GenStage

defmodule Twitter.Producer do
	use GenStage

	def start_link(track) do
		IO.puts "track: #{track}"
		GenStage.start_link(__MODULE__, track, name: __MODULE__)
	end

	def init(track) do
		stream = twitter_stream(track)
		#stream = bigfile_stream
		
		{:producer, stream}
	end

	def handle_demand(demand, stream) when demand > 0 do
		events = stream |> Enum.take(demand)
		{:noreply, events, stream}
	end

	defp twitter_stream(track) do
		ExTwitter.stream_filter([track: track], :infinity)
	end

	defp bigfile_stream do
		stream = File.stream!("../genstage/stagetest/big.txt",[],:line)
	end

end