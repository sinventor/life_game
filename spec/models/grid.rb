require 'spec_helper'
require 'models/grid'
require 'models/cell'

describe Grid do
	let(:cell1) { Cell.new(2, 2, true) }
	let(:cell2) { Cell.new(3, 5, true) }
  let(:cell3) { Cell.new(4, 6, false) }
	let(:cells) { [cell1, cell2, cell3] }
  let(:grid) { Grid.new(cells) }
  let(:all_dead_grid) { Grid.new(all_dead_cells) }
  let(:expected_width_for_grid) { 5 }
  let(:expected_height_for_grid) { 7 }

	let(:dead_cell1) { Cell.new(2, 2, false) }
	let(:dead_cell2) { Cell.new(3, 5, false) }
	let(:all_dead_cells) { [dead_cell1, dead_cell2] }

  let(:cell1_for_grid2) { Cell.new(11, 10, true) }
  let(:cell2_for_grid2) { Cell.new(2, 7, true) }
  let(:cell3_for_grid2) { Cell.new(6, 2, true) }
  let(:grid2) { Grid.new([cell1_for_grid2, cell2_for_grid2, cell3_for_grid2]) }	

	describe "correct dimensions computation" do
		subject { grid }

		it "#width" do
			expect(subject.width).to eq(expected_width_for_grid)
		end

		it "#height" do
			expect(subject.height).to eq(expected_height_for_grid)
		end
	end

	describe "#at_least_one_alive?" do
		context "have alive cell(s)" do
			subject { grid }

			it "should return true" do
				expect(subject.at_least_one_alive?).to eq(true)
			end
		end

		context "with all dead cells" do
			subject { all_dead_grid }

			it "should return false" do
				expect(subject.at_least_one_alive?).to eq(false)
			end
		end
	end

	describe "#cell_at" do

		context "within boundaries" do
			subject { grid.cell_at(1, 4) }

			it "should return cell with the same coordinates" do
				expect(subject).not_to be_nil
				expect(subject.y).to eq(4)
				expect(subject.x).to eq(1)
			end
		end

		context "out of boundaries" do
			subject { grid.cell_at(8912, 78) }

			it "should return nil" do
				expect(subject).to be_nil
			end
		end
	end

  describe "movement" do
    describe "#top" do
      context "when having top cell" do
        let(:target_cell) { grid.cell_at(4, 2) }
        subject { grid.send(:top, target_cell) }

        it "should return top cell" do
          expect(subject.y).to eq(1)
        end
      end

      context "when not having top cell" do
        let(:target_cell) { grid.cell_at(4, 0) }
        subject { grid.send(:top, target_cell) }

        it "should return nil" do
          expect(subject).to be_nil
        end
      end
    end

    describe "#left" do
      context "when having left cell" do
        let(:target_cell) { grid.cell_at(4, 3) }
        subject { grid.send(:left, target_cell) }

        it "should return left cell" do
          expect(subject.x).to eq(3)
        end
      end

      context "when not having left cell" do
        let(:target_cell) { grid.cell_at(0, 6) }
        subject { grid.send(:left, target_cell) }

        it "should return nil" do
          expect(subject).to be_nil
        end
      end
    end
  end

  describe "#find_neighbours" do
    let(:target_cell) { grid.cell_at(4, 3) }
    subject { grid.find_neighbours(target_cell) }

    it "should include left cell" do
      expect(subject).to include(grid.send(:left, target_cell))
    end

    it "should include top cell" do
      expect(subject).to include(grid.send(:top, target_cell))
    end
  end

  describe "#==" do
    let(:first_grid) { grid.dup }
    let(:second_grid) { first_grid.dup }
    let(:third_grid) { grid2.dup }

    context "when grids are equal" do
      it "should return true" do
        expect(first_grid).to eq(second_grid)
      end
    end

    context "when grids are not equal" do
      it "should return false" do
        expect(first_grid).not_to eq(third_grid)
      end
    end
  end
end