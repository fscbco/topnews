class StarsController < ApplicationController
  def create
    @star = Starrable.create!(user: current_user, story_id: params[:story_id])

    respond_to do |format|
      format.json { render json: { star: @star } }
    end
  rescue => error
    respond_to do |format|
      format.json { render json: { error: error.message} , status: :bad_request }
    end
  end
  
  def delete
    @star = Starrable.find_by!(user: current_user, story_id: params[:story_id]).destroy
    
    respond_to do |format|
      format.json { render json: { star: @star } }
    end
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.json { render json: { error: "Delete failed: Could not find star"} , status: :bad_request }
    end
  end
end
