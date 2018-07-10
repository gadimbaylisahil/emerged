class TrendRatioCalculator
	def initialize(likes:, shares:, views:, time:)
		@likes = likes
		@shares = shares
		@views = views
		@time = time
	end
	
	# Todo: Come up with algorithm for trending creations
	def run
		(@likes + @shares + @views)
	end
end