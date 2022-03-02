module ApplicationHelper
  include Pagy::Frontend

  def full_title page_title = ""
    base_title = t("title")
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def log_in user
    session[:user_id] = user.id
  end
end
