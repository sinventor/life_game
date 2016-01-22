class Game
  attr_reader :grid

  def initialize(grid)
    @current_grid = grid
    @previous_grid = nil
    @round_count = 0
    @state_not_change = false
    @history = []
  end
end