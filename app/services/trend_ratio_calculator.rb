class TrendRatioCalculator
	def initialize(likes:, shares:, views:, comments:, time:)
		@likes = likes
		@shares = shares
		@views = views
		@comments = comments
		@time = time
	end
	
	# Todo: Come up with algorithm for trending creations
	def run
		(@likes + @shares + @views + @comments)
	end
end