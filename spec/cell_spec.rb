require 'cell'

describe 'cell' do

	let(:cell)           {Cell.new(4, 9) }
	let(:neighbour_cell) {Cell.new(3, 8) }
	let(:unsolved_cell)  {Cell.new(1, 0) }
	let(:random_cell)    {Cell.new(71, 9)}
	let(:neighbours)     {[Cell.new(0, 1),Cell.new(0, 2), Cell.new(0, 3), Cell.new(0, 4), Cell.new(0, 5), Cell.new(0, 6), Cell.new(0, 7), Cell.new(0, 8)]}

	context 'on initialization' do
		it 'it has a value' do
			expect(cell.value).to eq 9
		end

		it 'should know which row it belongs to, based on position' do
			expect(cell.row).to eq 0
		end

		it 'should know which column it belongs to, based on position' do
			expect(cell.column).to eq 4
		end

		it 'should know which box it belongs to, based on position' do
			expect(cell.box).to eq 3
		end

		it 'should have an empty list of neighbours' do
			expect(cell.neighbours).to be_empty
		end
	end

	context 'solving each cell' do
		it 'should know if it is filled out' do
			expect(cell.filled_out?).to be_truthy
		end

		it 'should know if it is not filled out' do
			expect(unsolved_cell.filled_out?).to be_falsey
		end

		it 'should know if two cells are neighbours' do
			expect(cell.neighbours?(unsolved_cell)).to be_truthy
		end

		it 'should know if two cells are not neighbours' do
			expect(cell.neighbours?(random_cell)).to be_falsey
		end

		it 'should be able to calculate the values present in neighbour cells' do
			cell.neighbours << neighbour_cell
			expect(cell.numbers_taken).to eq [8]
		end

		it 'should be able to calculate a list of possible candidate values for cell being solved' do
			cell.neighbours << neighbour_cell
			expect(cell.candidates).to eq [1, 2, 3, 4, 5, 6, 7, 9]
		end

		it 'should be able to solve itself if there is only one possible candidate' do
			neighbours.each {|n| unsolved_cell.neighbours << n}
			unsolved_cell.solve
			expect(unsolved_cell.value).to eq 9
		end

		it 'should return self if the cell is already filled out' do
			expect(cell.solve).to eq cell
			expect(cell.value).to eq 9
		end

		it 'should return self if the cell has more than one possible candidate' do
			neighbours.take(5).each {|n| unsolved_cell.neighbours << n}
			unsolved_cell.solve
			expect(unsolved_cell.value).to eq 0
		end
	end
end
