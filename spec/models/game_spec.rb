require 'spec_helper'
require 'models/grid'
require 'models/cell'
require 'models/game'

describe Game do
  let(:separator) { File::Separator }

  # [ ][ ][ ][ ][ ][ ]
  # [ ][ ][ ][ ][ ][ ]
  # [ ][*][ ][*][*][ ]
  # [ ][ ][*][*][ ][ ]
  # [ ][*][ ][ ][*][ ]
  #        ^
  #        |
  let(:sample1) { "file_samples#{separator}configuration_5.csv" }
  
  let(:game) { Game.new(Grid.from_file(sample1)) }
  let(:game_grid) { game.current_grid }
  let(:prev_grid) { game_grid.clone }

  it "current_grid should have correct dimensions" do 
    expect(game_grid.width).to eq(6)
    expect(game_grid.height).to eq(5)
  end

  describe "iteration process" do
    before do
      game.do_iteration
    end

    it "cell that has exactly three alive neighbours should be reproduced" do
      expect(game.current_grid.cell_at(1,3).alive).to eq(true)
    end

    it "alive cell that has greater than 3 alive neigbours should be killed" do
      expect(game.current_grid.cell_at(2, 3).alive).to eq(false)
    end

    it "dead cell that has less than 3 alive neighbours should leave dead" do
      expect(game.current_grid.cell_at(5, 3).alive).to eq(false)
    end

    it "alive cell that has two alive neigbours should leave alive" do
      expect(game.current_grid.cell_at(4, 2).alive).to eq(true)
    end

    it "previous grid should set after each iteration" do
      expect(game.previous_grid).not_to be_nil
    end

    it "history should fill after each iteration" do
      expect(game.history.count).to eq(1)
    end
  end
  
end