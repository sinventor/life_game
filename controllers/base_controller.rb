require './views/base_view'

class BaseController
  def render(view, method, locals)
    view.send(method, locals)
  end

  def take_choice(variants)
    variants.each do |variant|
      BaseView.colorize_output("#{variant[:key]} - #{variant[:value]}")
    end
    BaseView.print_output("Ваш вариант: ")
    gets.chomp
  end

  def take_single_choice(message, new_line=false)
    if new_line
      BaseView.puts_output(message)
    else
      BaseView.print_output(message)
    end
    gets.chomp
  end

  def choices
    [
      {
        key: 1,
        value: 'Выйти'
      },
      {
        key: 2,
        value: 'Перейти в другой скоуп'
      }
    ]
  end
end