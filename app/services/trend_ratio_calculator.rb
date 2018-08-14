class TrendRatioCalculator
	def initialize(shares:, views:, time:)
		@shares = shares
		@views = views
		@time = time
	end
	
	# Todo: Come up with algorithm for trending creations
	def run
		(@shares + @views)
	end
end