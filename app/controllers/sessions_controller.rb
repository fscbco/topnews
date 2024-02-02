class SessionsController < Devise::SessionsController
  # Display welcome message when user successfully signs in
  def create
    super do |resource|
      if resource.persisted?
        flash[:notice] = "Welcome back, #{resource.email}!"
      end
    end
  end
end
