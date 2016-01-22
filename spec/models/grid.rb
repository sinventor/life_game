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
end