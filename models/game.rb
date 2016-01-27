class Game
  attr_reader :current_grid, :history, :round_count, :reason

  def initialize(grid)
    @current_grid = grid
    @previous_grid = nil
    @round_count = 0
    @state_not_change = false
    @history = []
    @finish_reason = ""
  end

  def do_iteration
    @previous_grid = @current_grid.dup
    @history.push(@previous_grid)
    @current_grid = @current_grid.next_state
    @round_count += 1
    if @current_grid == @previous_grid
      @state_not_change = true
      @reason = "Конфигурация по сравнению с предыдущей не изменилась"
    end
  end

  def stop?
    !at_least_one_alive? ||
    @state_not_change ||
    in_history?
  end

  def in_history?
    res = @history.any? do |insp_grid|
      insp_grid == @current_grid
    end
    @reason = "Такая конфигурация уже существовала" if res
    res
  end

  def at_least_one_alive?
    res = @current_grid.at_least_one_alive?
    @reason = "Нет ни одной живой клетки" if !res
    res
  end
end