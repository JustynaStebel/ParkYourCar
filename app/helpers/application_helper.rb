module ApplicationHelper
  def title
    params[:controller].humanize
  end
end
