class BaseView
  def self.colorize_output(string)
    puts "\t\e[32m#{string}\e[0m"
  end

  def self.print_output(string)
    print "\t#{string}"
  end
end