class PostsController < ApplicationController
  def create
    post = Post.find_or_create_by(
      user_id: current_user.id,
      title: params[:title],
      url: params[:url],
      item_id: params[:id])

    flash[:success] = "Liked post!" if post.save!
  rescue => e
    flash[:alert] = "Something went wrong. Please try again."
    Rails.logger.info(e.message)
  ensure
    redirect_to root_path
  end
end
