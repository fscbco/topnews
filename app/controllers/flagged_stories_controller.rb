class FlaggedStoriesController < ApplicationController
  before_action :set_flagged_story, only: %i[ show edit update destroy ]

  # GET /flagged_stories or /flagged_stories.json
  def index
    @flagged_stories = FlaggedStory.all
  end

  # GET /flagged_stories/1 or /flagged_stories/1.json
  def show
    if @flagged_story
      picks
      users_flagged_story
    end
  end

  # GET /flagged_stories/1/edit
  def edit
  end

  # POST /flagged_stories or /flagged_stories.json
  def create
    @flagged_story = FlaggedStory.new(flagged_story_params)

    respond_to do |format|
      if @flagged_story.save

        @pick = Pick.new(:user_id => current_user.id, :flagged_story_id => @flagged_story.id)

        if @pick.save
          format.html { redirect_to flagged_story_url(@flagged_story), notice: "Flagged story was successfully created." }
          format.json { render :show, status: :created, location: @flagged_story }
        end
        # also create pick table
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @flagged_story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flagged_stories/1 or /flagged_stories/1.json
  def update
    respond_to do |format|
      if @flagged_story.update(flagged_story_params)
        format.html { redirect_to flagged_story_url(@flagged_story), notice: "Flagged story was successfully updated." }
        format.json { render :show, status: :ok, location: @flagged_story }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @flagged_story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flagged_stories/1 or /flagged_stories/1.json
  def destroy
    @flagged_story.destroy

    respond_to do |format|
      format.html { redirect_to flagged_stories_url, notice: "Flagged story was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flagged_story
      @flagged_story = FlaggedStory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def flagged_story_params
      params.require(:flagged_story).permit(:title, :by, :external_id, :score, :url)
    end

    def picks
      @picks= @flagged_story.picks
    end

    def users_flagged_story
      @picks.map do |p|
      id = p.user_id
      user = User.find_by(id: id)
      user.first_name
    end
  end
end
