module ApplicationHelper

  # Combines the user's first and last name.
  def full_name(user)
    user.first_name.capitalize + " " + user.last_name.capitalize
  end

  # Returns the full title on a per-page basis.
  def full_title(page_title = "")
  	base_title = "Facebook Clone"
  	if page_title.empty?
  		base_title
  	else
  		page_title + " | " + base_title
  	end
  end

end
