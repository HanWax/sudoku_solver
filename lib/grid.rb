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

	def display_solution
		rows = []
		rows << [cells[0..8].map {|cell| cell.value}]
		rows << [cells[9..17].map {|cell| cell.value}]
		rows << [cells[18..26].map {|cell| cell.value}]
		rows << [cells[27..35].map {|cell| cell.value}]
		rows << [cells[36..44].map {|cell| cell.value}]
		rows << [cells[45..53].map {|cell| cell.value}]
		rows << [cells[54..62].map {|cell| cell.value}]
		rows << [cells[63..71].map {|cell| cell.value}]
		rows << [cells[72..80].map {|cell| cell.value}]
		table = Terminal::Table.new :rows => rows
		puts table
	end
end
