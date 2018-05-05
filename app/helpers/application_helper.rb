module ApplicationHelper
  def page_active?(path:)
    'active' if current_page?(path)
  end
  def like_class(resource:)
    'd-none' if current_user.liked? resource
  end
  def unlike_class(resource:)
    'd-none' unless current_user.liked? resource
  end
end
