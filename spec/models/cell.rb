require 'spec_helper'
require 'models/cell'

describe Cell do
	let (:cell) { Cell.new(5, 3, false) }
	let(:alive_cell) { Cell.new(2, 6, true) }
	let(:dead_cell) { Cell.new(12, 4, false) }

	describe "#initialize" do
		subject { cell }

		it "should be an instance of Cell" do
			expect(subject).to be_a Cell
		end
	end

	context "correct state" do
		describe "#alive?" do
			subject { alive_cell }

			it "should be alive" do
				expect(subject.alive?).to eq(true)
			end
		end

		describe "#dead?" do
			subject { dead_cell }

			it "should be dead" do
				expect(subject.dead?).to eq(true)
			end
		end
	end

	context "coordinates access" do
		describe "#x" do
			subject { cell }

			it "should return a coordinate (x)" do
				expect(subject.x).to eq(cell.x)
			end

			it "should return a coordinate (y)" do
				expect(subject.y).to eq(cell.y)
			end
		end
	end
end