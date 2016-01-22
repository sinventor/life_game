class Grid
	attr_reader :cells, :width, :height

	def initialize(cells)
		@cells = cells
		@width = compute_width
		@height = compute_height
		normalize!
	end 
	
	def at_least_one_alive?
		cells.any? { |cell| cell.alive? }
	end

	def cell_at(x, y)
		cells.find { |cell| cell.x == x && cell.y == y }
	end

	private

	def compute_width
		max_x = cells.map(&:x).max
		max_x ? max_x + 1 : 0
	end

	def compute_height
		max_y = cells.map(&:y).max
		max_y ? max_y + 1 : 0
	end

	private

	def normalize!
		height.times do |y|
			width.times do |x|
				@cells.push(Cell.new(x, y, false)) unless cell_at(x, y)
			end
		end
	end
end