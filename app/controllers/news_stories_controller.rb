class NewsStoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @pagy_ns, @news_stories = pagy(NewsStory.order(time: :desc))
    @pagy_ps, @pinned_news_stories = pagy(NewsStory.order(time: :desc).pinned, page_param: :page_pinned)

    respond_to do |format|
      format.html
    end
  rescue Pagy::OverflowError
    redirect_to news_stories_path
  end
  
  def pin
    news_story = NewsStory.find_by(id: pin_params[:id])
    
    if current_user.news_stories.include?(news_story)
      current_user.news_stories.delete(news_story)
      @pinned = false
    else
      current_user.news_stories << news_story
      @pinned = true
    end

    respond_to do |format|
      format.json { render json: { pinned: @pinned }, status: :ok }
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def pin_params
    params.permit(:id)
  end

  def news_stories_params
    params.permit(:page, :page_pinned)
  end
end