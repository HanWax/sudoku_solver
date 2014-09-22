require_relative 'grid'

class Cell

	attr_accessor :value, :neighbours
	attr_reader :box, :column, :row

	def initialize (position, value)
		@value = value
		@row = position / 9
		@column = position % 9
		@box = column / 3 * 3 + row / 3
		@neighbours = []
	end

	def filled_out?
		@value != 0
	end

	def neighbours? other_cell
		row == other_cell.row || column == other_cell.column || box == other_cell.box ? true : false
	end

	def numbers_taken
		neighbours.map {|neighbour| neighbour.value}
	end

	def candidates
		(1..9).to_a - numbers_taken
	end

	def solve
		if filled_out? || candidates.count > 1
			self
		else
			@value = candidates[0]
		end
	end
end
