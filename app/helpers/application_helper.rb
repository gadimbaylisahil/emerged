module ApplicationHelper
  def page_active?(path:)
    return 'active' if current_page?(path)
  end
end
