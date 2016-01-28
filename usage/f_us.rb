require './controllers/games_controller'
require './controllers/grids_controller'
require './views/base_view'

@start_point = BaseController.new
@variants = [
  {
    key: 1,
    value: 'Перейти в скоуп games'
  },
  {
    key: 2,
    value: 'Перейти в скоуп grids'
  },
  {
    key: 'другая',
    value: 'Выйти'
  }
]

def show_menu
  case @start_point.take_choice(@variants)
  when "1"
    game_starter = GamesController.new
    game_starter.start
  when "2"
    grid_starter = GridsController.new
    grid_starter.start
  when nil
    show_menu
  else 
    exit  
  end
end
# show_menu
until show_menu == "q"
  show_menu
end

