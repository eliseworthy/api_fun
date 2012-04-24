module ApplicationHelper
  def title
    title = "API Fun!| #{controller.action_name.capitalize}"
  end
end
