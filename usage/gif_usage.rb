require './models/game'
require './models/grid'
require 'rmagick'
include Magick

@image_list = ImageList.new
@margin = {
  left: 20,
  top: 20
}
@cell_d = 20
@drawing_d = 16

@configuration_file = 'file_samples/configuration_9.csv'
@drawing_file = 'images/demos/demonstration_9.gif'

def add_to_image(grid, round_number=nil)
  draw = Draw.new
  build_grid(draw, grid)

  img = Image.new(grid.width * 20 + 40, grid.height * 20 + 100)
  draw.annotate(img, 200, 30, @margin[:left] + 20, grid.height * @cell_d + @margin[:left] + 20, "Номер раунда: #{round_number}") if round_number
  draw.draw(img)
  @image_list << img
end

def add_cyclic_frame_with_annotate(grid, reason)
  100.times do
    draw = Draw.new
    build_grid(draw, grid)
    img = Image.new(grid.width * @cell_d + @margin[:left] * 2, grid.height * @cell_d + @margin[:top] * 2 + 80)
    draw.annotate(img, 200, 60, @margin[:left] + 20, grid.height * @cell_d + @margin[:left] + 20, reason)
    draw.draw(img)
    @image_list << img
  end
end

def build_grid(draw, grid)
  grid.height.times do |row|
    grid.width.times do |col|
      draw.line(col * @cell_d + @margin[:left], @margin[:top],
                col * @cell_d + @margin[:left], grid.height * 20 + @margin[:top])
    end
    draw.line(@margin[:left], row * @cell_d + @margin[:top],
              grid.width * @cell_d + @margin[:left], row * @cell_d + @margin[:top])
  end
  draw.line(grid.width * @cell_d + @margin[:left], @margin[:top],
            grid.width * @cell_d + @margin[:left], grid.height * @cell_d + @margin[:top])
  draw.line(@margin[:left], grid.height * @cell_d + @margin[:top],
            grid.width * @cell_d + @margin[:left], grid.height * @cell_d + @margin[:top])
  draw.fill '#e891a3'
  grid.cells.each do |cell|
    left_indent = get_left_indent(cell.x * @cell_d, @cell_d, @drawing_d)
    right_indent = get_right_indent(cell.x * @cell_d, @cell_d, @drawing_d)
    top_indent = get_top_indent(cell.y * @cell_d, @cell_d, @drawing_d)
    bottom_indent = get_bottom_indent(cell.y * @cell_d, @cell_d, @drawing_d)
    draw.rectangle(left_indent + @margin[:left], top_indent + @margin[:top],
                   right_indent + @margin[:left], bottom_indent + @margin[:top]) if cell.alive?
  end
end

def write_game_cycle
  @image_list.write(@drawing_file)
end

def get_left_indent(x, cell_width, drawing_width)
  return x if drawing_width >= cell_width
  x + (cell_width - drawing_width) / 2
end

def get_right_indent(x, cell_width, drawing_width)
  return x if drawing_width >= cell_width
  x + (cell_width - drawing_width) / 2 + drawing_width
end

def get_top_indent(y, cell_height, drawing_height)
  return y if drawing_height >= cell_height
  y + (cell_height - drawing_height) / 2
end

def get_bottom_indent(y, cell_height, drawing_height)
  return y if drawing_height >= cell_height
  y + (cell_height - drawing_height) / 2 + drawing_height
end

game = Game.new(Grid.from_file(@configuration_file))

add_to_image(game.current_grid)

while !game.stop?
  game.do_iteration
  add_to_image(game.current_grid, game.round_count)
end

add_cyclic_frame_with_annotate(game.current_grid, "Количество раундов: #{game.round_count}" + "\n" + game.finish_reason)
write_game_cycle