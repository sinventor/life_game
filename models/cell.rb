require './models/base_record/base_record'
puts BaseRecord.class
class Cell < BaseRecord::SimpleRecord
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
end