class StarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[create]
  before_action :set_star, only: %i[destroy]

  def create
    star = Star.new(post: @post, user: current_user)

    if star.save
      flash[:notice] = 'Star created successfully!'
    else
      flash[:alert] = star.errors.full_messages.to_sentence if star.errors
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    if @star.destroy
      flash[:notice] = 'Star destroyed successfully!'
    else
      flash[:alert] = star.errors.full_messages.to_sentence if star.errors
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def set_star
    @star = Star.find(params[:id])

    # Prevent users from destroying stars they don't own
    raise StandardError, "Star not found!" unless @star.user_id == current_user.id
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
