require 'spec_helper'
require 'controllers/grids_controller'
require './errors/configuration_file_not_found_error'

describe GridsController do
  let(:instance) { GridsController.new }
  
  describe "#show" do
    context "when file exist" do
      before do
        instance.show(1)
        @grid = instance.instance_variable_get(:@grid)
      end

      it "should assign instance variable @grid" do
        expect(instance.instance_variable_get(:@grid)).not_to be_nil
      end

      it "should correctly compute a width" do
        expect(@grid.width).to eq 37
      end
    end

    context "when file does not exist" do
      before do
        instance.show(367)
      end

      it 'instance variable should be a nil' do
        expect(instance.instance_variable_get(:@grid)).to be_nil
      end
    end
  end
end