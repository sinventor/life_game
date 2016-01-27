class GameView
  def self.display(locals)
    game = locals[:game]
    clear
    draw_board(game.current_grid)
  end

  def self.draw_board(board)
    print "\e[H"
    puts (" " + "_") * (board.width)

    board.height.times do |i|
      print "|"

      board.width.times do |j|
        drawing_cell = board.cell_at(j, i)

        if drawing_cell && drawing_cell.alive?
          print "\e[41m \e[m"
        else
          print "_"
        end
        print "|"    
      end
      puts
    end
  end

  private

  def self.clear
    print "\e[2J"
  end
end