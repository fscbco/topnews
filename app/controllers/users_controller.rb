class UsersController < ApplicationController
  def index
    @users = User.paginate(page:, per_page:)
  end
end
