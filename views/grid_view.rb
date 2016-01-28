require './views/base_view'

class GridView < BaseView
  def self.display(locals)
    board = locals[:grid]
    clear
    draw_board(board)
  end
end