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
    gets.chop
  end
end