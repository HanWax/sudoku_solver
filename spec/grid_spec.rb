require 'grid'

describe Grid do
    let(:puzzle) { '015003002000100906270068430490002017501040380003905000900081040860070025037204600' }
    let(:grid) { Grid.new(puzzle) }

    context "initialization" do

        it 'should have 81 cells' do
            expect(grid.cells.count).to eq 81
        end

        it 'should have an unsolved first cell' do
            expect(grid.cells[0].filled_out?).to be_falsey
        end

        it 'should have a solved second cell with value 1' do
            expect(grid.cells[1].value).to eq 1
            expect(grid.cells[1].filled_out?).to be_truthy
        end

        it 'should assign an index to each number in the puzzle' do
            expect(grid.add_index(puzzle).last).to eq [80, 0]
        end

        it 'should assign puzzle values to cell' do
            grid.assign_values(puzzle)
            expect(grid.cells[1].value).to eq 1
        end
    end

    context 'neighbours' do

        it 'should add neighbours to each cell' do
            grid.add_neighbours_to_cells
            expect(grid.cells[1].neighbours.count).to eq 21
        end
    end
end
