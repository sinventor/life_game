require './views/base_view'

class GameView < BaseView
  def self.display(locals)
    game = locals[:game]
    clear
    draw_board(game.current_grid)
  end
end