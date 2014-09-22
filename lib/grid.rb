require_relative 'cell'
require 'terminal-table'
SIZE = 81

class Grid

	attr_accessor :cells, :puzzle

	def initialize puzzle
		@puzzle = puzzle
		@cells = assign_values(puzzle)
	end

	def add_index puzzle
		puzzle.chars.map.with_index {|n, index| [index, n.to_i]}
	end

	def assign_values puzzle
		add_index(puzzle).map {|entry| Cell.new(entry[0], entry[1])}
	end

	def add_neighbours_to_cells
		cells.each {|cell| neighbours_list(cell)}
	end

	def neighbours_list target_cell
		cells.each {|cell| cell.neighbours?(target_cell) ? target_cell.neighbours << cell : false}
	end

	def solve
		outstanding_before, looping = SIZE, false
		while !solved? && !looping
			try_to_solve
			outstanding         = cells.reject {|c| c.filled_out? }.count
			looping             = outstanding_before == outstanding
			outstanding_before  = outstanding
		end
	end

	def try_to_solve
		cells.each {|cell| cell.solve}
	end

	def solved?
		cells.all? {|cell| cell.filled_out?}
	end

end
