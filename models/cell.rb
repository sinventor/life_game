class Cell
	attr_reader :x, :y, :alive

	def initialize(x, y, alive)
		@x = x
		@y = y
		@alive = alive
	end

	def alive?
		alive
	end

	def dead?
		!alive?
	end

	def ==(other)
		x == other.x &&
		y == other.y &&
		alive == other.alive
	end
end