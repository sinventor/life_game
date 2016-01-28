require 'csv'
require './models/cell'
require './overrides/nil_class'
require './overrides/string'

class Grid
	attr_reader :cells, :width, :height

	def initialize(cells)
		@cells = cells.dup
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

	def compute_width
		max_x = cells.map(&:x).max
		max_x ? max_x + 1 : 0
	end

	def compute_height
		max_y = cells.map(&:y).max
		max_y ? max_y + 1 : 0
	end

  def find_neighbours(cell)
    %i[left top right bottom top_left top_right bottom_right bottom_left].
        map { |area| send(area, cell) }.
        compact
  end

  def extract_alive_neigbours(cell)
    all_neighbours = find_neighbours(cell)
    all_neighbours.find_all { |cell| cell.alive? }
  end

  def next_state
    new_cells = cells.map do |cell|
      if cell.alive?
        kill?(cell) ? Cell.new(cell.x, cell.y, false) : cell.dup
      else
        reproduce?(cell) ? Cell.new(cell.x, cell.y, true) : cell.dup
      end
    end
    self.class.new(new_cells)
  end

  def kill?(cell)
    alive_neighbour_cells = extract_alive_neigbours(cell)
    !alive_neighbour_cells.count.between?(2, 3)
  end

  def reproduce?(cell)
    alive_neighbour_cells = extract_alive_neigbours(cell)
    alive_neighbour_cells.count == 3
  end

  def ==(other)
    return false if !other.is_a?(self.class)    ||
                    other.width != self.width || 
                    other.height != self.height
    cells.each do |cell|
      return false if cell != other.cell_at(cell.x, cell.y)
    end
    true
  end

  def self.from_file(file)
    cells = []
    CSV.foreach(file, headers: true) do |row|
      cells << Cell.new(row['x'].to_i, row['y'].to_i, row['alive'].to_bool)
    end
    self.new(cells)
  end

  def self.write_to_file(file, cells)
    # cells = [Cell.new(4, 6, true)]
    CSV.open(file, 'w', write_headers: true, headers: ['x', 'y', 'alive']) do |csv|
      cells.each do |cell|
        csv << [cell.x, cell.y, cell.alive ? 't' : 'f']
      end
    end
  end

	private

	def normalize!
		height.times do |y|
			width.times do |x|
				@cells.push(Cell.new(x, y, false)) unless cell_at(x, y)
			end
		end
	end

  def top(cell)
    cell_at(cell.x, cell.y - 1)
  end

  def left(cell)
    cell_at(cell.x - 1, cell.y)
  end

  def bottom(cell)
    cell_at(cell.x, cell.y + 1)
  end

  def right(cell)
    cell_at(cell.x + 1, cell.y)
  end

  def top_left(cell)
    cell_at(cell.x - 1, cell.y - 1)
  end

  def top_right(cell)
    cell_at(cell.x + 1, cell.y - 1)
  end

  def bottom_right(cell)
    cell_at(cell.x + 1, cell.y + 1)
  end

  def bottom_left(cell)
    cell_at(cell.x - 1, cell.y + 1)
  end
end