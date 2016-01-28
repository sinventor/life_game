require './models/grid'
require './errors/configuration_file_not_found_error'

class Game
  attr_reader :current_grid, :previous_grid, :history, :round_count, :finish_reason
  RESOURCE_FILE_PATH = 'file_samples'
  USER_FILE_PATH = 'user_files'
  SEPARATOR = File::Separator
  FILE_EXTENSION = 'csv'

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
      @finish_reason = "Конфигурация по сравнению с предыдущей не изменилась"
    end
  end

  def self.find(number)
    file = "#{RESOURCE_FILE_PATH}#{SEPARATOR}configuration_#{number}.#{FILE_EXTENSION}"
    file = "#{USER_FILE_PATH}#{SEPARATOR}configuration_#{number}.#{FILE_EXTENSION}" unless File.exists?(file)
    raise ConfigurationFileNotFoundError unless File.exists?(file)
    self.new(Grid.from_file(file))
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
    @finish_reason = "Такая конфигурация уже существовала" if res
    res
  end

  def at_least_one_alive?
    res = @current_grid.at_least_one_alive?
    @finish_reason = "Нет ни одной живой клетки" if !res
    res
  end
end