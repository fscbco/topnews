class LikesController < ApplicationController

  def create
    validated_params = LikesCreateContract.new(user: current_user).call(request.params)
    if validated_params.errors.empty?
      Like.create!(validated_params.to_h.merge(user_id: current_user.id))
    else
      format_errors_for_flash(validated_params)
    end
    redirect_back(fallback_location: root_path)
  end

end
