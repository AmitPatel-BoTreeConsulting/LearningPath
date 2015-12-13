module ApplicationHelper
  def links_count
    current_user.links.count
  end

  def favourite_links_count
    current_user.favourite_links.count
  end
end
