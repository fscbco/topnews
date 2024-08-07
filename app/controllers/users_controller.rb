class UsersController < ApplicationController

    def index
        @users = User.all
    end

    def bookmarks
        @user = User.find(params[:id])
        @bookmarks = @user.bookmarks.map(&:article)
    end
end