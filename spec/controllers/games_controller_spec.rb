require 'spec_helper'
require 'controllers/games_controller'
require 'controllers/base_controller'
require './errors/configuration_file_not_found_error'
require './models/game'
require './views/base_view'

describe GamesController do
  let(:instance) { GamesController.new }

  describe "#show" do
    context("when configuration file exists") do
      before do
        instance.show(1)
      end

      it "should assign found configuration to @game" do        
        expect(instance.instance_variable_get(:@game)).not_to be_nil  
      end

      it "@game should be an instance of Game" do
        expect(instance.instance_variable_get(:@game)).to be_a(Game)
      end
    end

    context "when configuration file does not exist" do
      before do
        instance.show(83434)
      end

      it "@game should be a nil" do
        expect(instance.instance_variable_get(:@game)).to be_nil
      end
    end
  end

  describe "#run" do
    context "when configuration file exist" do
      before do
        instance.run(2)
      end

      it "should be assign local variable @game" do
        expect(instance.instance_variable_get(:@game)).not_to be_nil
      end

      it "round count should be right" do
        expect(instance.instance_variable_get(:@game).round_count).to eq 6
      end

      it "game configuration in certain moment should be in history" do
        expect(instance.instance_variable_get(:@game).in_history?).to eq(true)
      end
    end
  end  
end