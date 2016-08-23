defmodule Twitter do
	
	def start(_type, _args) do
		import Supervisor.Spec

		workers = [
			worker(Twitter.Producer, ["#Rio2016"]),
			worker(Twitter.Consumer, [], id: 1),
			worker(Twitter.Consumer, [], id: 2),
			worker(Twitter.Consumer, [], id: 3)
		]
		Supervisor.start_link(workers, strategy: :one_for_one)
	end

end
