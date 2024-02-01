class SessionsController < Devise::SessionsController
  def create
    super do |resource|
      if resource.persisted?
        flash[:notice] = "Welcome back, #{resource.email}!"
      end
    end
  end
end
