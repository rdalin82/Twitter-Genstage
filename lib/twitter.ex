defmodule Twitter.Application do

	def start(_type, _args) do
		import Supervisor.Spec

		workers = [
			worker(Twitter.Producer, ["Trump"]),
			worker(Twitter.Consumer, [], id: 1),
			worker(Twitter.Consumer, [], id: 2),
			worker(Twitter.Consumer, [], id: 3),
			worker(Twitter.ConsumerServer, [], id: 4),
			worker(Twitter.WordFreqServer, [], id: 5)
		]
		Supervisor.start_link(workers, strategy: :one_for_one)
	end

end
