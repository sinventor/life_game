class BaseView
  def self.colorize_output(string)
    puts "\t\e[32m#{string}\e[0m"
  end

  def self.print_output(string, tab=false)
    print "#{"\t" if tab}#{string}"
  end

  def self.puts_output(string)
    puts "#{string}\n"
  end

  def self.display_with_value(options)
    message = options[:message]
    help = options[:help]
    puts "\e[34m#{message}\e[0m"
    puts "\e[34m#{help}\e[0m" if help
  end

  def self.success_message(locals)
    message = locals[:message]
    green(message)
  end

  def self.alert_message(locals)
    message = locals[:message]
    red(message)
  end

  def self.draw_board(board)
    print "\e[H"
    puts (" " + "_") * (board.width)

    board.height.times do |i|
      print "|"

      board.width.times do |j|
        drawing_cell = board.cell_at(j, i)

        if drawing_cell && drawing_cell.alive?
          print "\e[41m*\e[m"
        else
          print "_"
        end
        print "|"    
      end
      puts
    end
  end

  protected
 
  def self.clear
    print "\e[2J"
  end

  private

  def self.green(string)
    puts "\t\e[32m#{string}\e[0m\n"
  end

  def self.red(string)
    puts "\t\e[31m#{string}\e[0m\n"
  end
end