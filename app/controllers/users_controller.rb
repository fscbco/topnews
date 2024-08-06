class UsersController < ApplicationController
    def bookmarks
        @user = User.find(params[:id])
        @bookmarks = @user.bookmarks.map(&:article)
    end
end