require './models/grid'
require './models/game'
require './controllers/base_controller'
require './views/game_view'

class GamesController < BaseController
  CHOICES = [
    {
      key: 1,
      value: 'Показать доску'
    },
    {
      key: 2,
      value: 'Запустить игровой процесс'
    },
    {
      key: 3,
      value: 'Выйти'
    }
  ]

  def show(number)
    @game = Game.find(number)
    render GameView, :display, game: @game
    start
  end

  def run(number)
    @game = Game.find(number)
    
    while !@game.stop?
      @game.do_iteration
      sleep 1
      render GameView, :display, game: @game
    end

    puts "Количество раундов: #{@game.round_count}"
    puts "Причина завершения: #{@game.finish_reason}"
    start
  end

  def start
    choice = take_choice(CHOICES)
    case choice
    when "1"
      show(1)
    when "2"
      run 1
    else
      exit
    end
  end
end