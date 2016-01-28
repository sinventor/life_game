require './models/grid'
require './views/base_view'
require './views/grid_view'
require './overrides/string'
require './overrides/nil_class'
require './controllers/base_controller'

class GridsController < BaseController
  CHOICES = [
    {
      key: 3,
      value: 'Создать новую конфигурацию игровой поверхности'
    },
    {
      key: 4,
      value: 'Отобразить конфигурацию'
    }
  ]

  def show(number)
    file = "file_samples/configuration_#{number}.csv"
    unless File.exist?(file)
      render(BaseView, :alert_message, message: "Конфигурации с номером #{number} не найдено")
      return nil
    end
    @grid = Grid.from_file(file)
    render GridView, :display, grid: @grid
  end

  def create
    number = take_single_choice('Введите номер записываемого файла: ')
    number = number && number.to_i || 1
    user_input = take_single_choice("x y alive (для окончания ввода - q или quit)", true)
    cells = []
    until ['q', 'quit'].include?(user_input)
      values = user_input.split(' ')
      x = values[0] && values[0].to_i || 1
      y = values[1] && values[1].to_i || 1
      alive = values[2] && values[2].to_bool || false
      cells.push(Cell.new(x, y, alive))
      user_input = take_single_choice("x y alive (для окончания ввода - q или quit)", true)
    end
    Grid.write_to_file("user_files/configuration_#{number}.csv", cells)
    render BaseView, :success_message, message: "Файл успешно записан и сохранен!"
  end

  def start
    choice = take_choice(choices)
    case choice
    when "3"
      render BaseView, :display_with_value, 
                message: "Создание новой конфигурации",
                help: "Введите данные через пробел"
      create
      start
    when "4"
      number = take_single_choice('Введите номер файла: ')
      number = number && number.to_i || 1
      show(number)
      render BaseView, :puts_output, "Доска ##{number}"
      start
    when "2"
      BaseView.puts_output("Выход из скоупа grids")
    else
      "q"
    end
  end

  def choices
    super + CHOICES
  end
end
