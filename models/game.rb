class Game
  attr_reader :grid

  def initialize(grid)
    @current_grid = grid
    @previous_grid = nil
    @round_count = 0
    @state_not_change = false
    @history = []
  end

  def do_iteration
    @previous_grid = @current_grid.dup
    history.push(previous_grid)
    @current_grid = @current_grid.next_state
    if @current_grid == @previous_grid
      @state_not_change = true
    end
  end

  def stop?
    !@current_grid.at_least_one_alive? || 
    @state_not_change ||
    in_history?
  end

  def in_history?
    history.any? do |insp_grid|
      insp_grid == @current_grid
    end
  end
end