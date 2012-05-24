module ApplicationHelper
  def active_class(path)
    " class='active'" if current_page?(path)
  end
end
