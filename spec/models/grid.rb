require 'spec_helper'
require 'models/grid'
require 'models/cell'

describe Grid do
	let(:cell1) { Cell.new(2, 2, true) }
	let(:cell2) { Cell.new(13, 34, true) }
	let(:cells) { [cell1, cell2] }

	let(:dead_cell1) { Cell.new(2, 5, false) }
	let(:dead_cell2) { Cell.new(3, 6, false) }
	let(:all_dead_cells) { [dead_cell1, dead_cell2] }

	let(:grid) { Grid.new(cells) }
	let(:all_dead_grid) { Grid.new(all_dead_cells) }

	describe "correct dimensions computation" do
		subject { grid }

		it "#width" do
			expect(subject.width).to eq(14)
		end

		it "#height" do
			expect(subject.height).to eq(35)
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
			subject { grid.cell_at(12, 16) }

			it "should return cell with the same coordinates" do
				expect(subject).not_to be_nil
				expect(subject.y).to eq(16)
				expect(subject.x).to eq(12)
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
        let(:target_cell) { grid.cell_at(4, 13) }
        subject { grid.send(:top, target_cell) }

        it "should return top cell" do
          expect(subject.y).to eq(12)
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
        let(:target_cell) { grid.cell_at(4, 13) }
        subject { grid.send(:left, target_cell) }

        it "should return top cell" do
          expect(subject.x).to eq(3)
        end
      end

      context "when not having left cell" do
        let(:target_cell) { grid.cell_at(0, 10) }
        subject { grid.send(:left, target_cell) }

        it "should return nil" do
          expect(subject).to be_nil
        end
      end
    end
  end

  describe "#find_neighbours" do
    let(:target_cell) { grid.cell_at(4, 13) }
    subject { grid.find_neighbours(target_cell) }

    it "should include left cell" do
      expect(subject).to include(grid.send(:left, target_cell))
    end

    it "should include top cell" do
      expect(subject).to include(grid.send(:top, target_cell))
    end
  end
end