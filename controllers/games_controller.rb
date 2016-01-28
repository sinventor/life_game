require './models/grid'
require './models/game'
require './controllers/base_controller'
require './views/game_view'
require './errors/configuration_file_not_found_error'

class GamesController < BaseController
  CHOICES = [
    {
      key: 3,
      value: 'Показать доску'
    },
    {
      key: 4,
      value: 'Запустить игровой процесс'
    },
    {
      key: 5,
      value: 'Выбрать новый файл конфигурации'
    }
  ]

  def show(number)
    @game = Game.find(number)
    render GameView, :display, game: @game
  rescue ConfigurationFileNotFoundError => e
    render BaseView, :puts_output, e.message
  end

  def run(number)
    @game = Game.find(number)
    
    while !@game.stop?
      @game.do_iteration
      sleep 1
      render GameView, :display, game: @game
    end

    render BaseView, :puts_output, "Количество раундов: #{@game.round_count}"
    render BaseView, :puts_output, "Причина завершения: #{@game.finish_reason}"
  end

  def start
    choice = take_choice(choices)
    case choice
    when "3"
      show(@number && @number.to_i || 1)
      start
    when "4"
      run(@number && @number.to_i || 1)
      start
    when "5"
      @number = take_single_choice("Выберите номер файла: ")
      start
    when "2"
      BaseView.puts_output("Выход из скоупа games")
    else
      "q"
    end
  end

  def choices
    super + CHOICES
  end
end