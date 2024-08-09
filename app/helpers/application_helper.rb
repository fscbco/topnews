module ApplicationHelper

  def users_nav
    User.all.select(:first_name, :last_name, :id)
  end

end
