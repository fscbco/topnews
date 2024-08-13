class NewsDetailsController < ApplicationController
  before_action :authenticate_user!
  def index
    @news_details = NewsDetail.includes(:users).page(params[:page])
  end

  def liked_index
    @news_details = NewsDetail.joins(:users).distinct.page(params[:page])
  end

  def upvote
    @news_detail = NewsDetail.find(params[:id])
    @news_detail.users << current_user

    respond_to do |format|
      format.html { redirect_to news_details_path } 
    end
  end

  def downvote
    @news_detail = NewsDetail.find(params[:id])
    @news_detail.users.delete(current_user)

    respond_to do |format|
      format.html { redirect_to news_details_path } 
    end
  end


end

# id: 507,
#   author: "el_benhameen",
#   comment_count: 1,
#   hn_id: 41231944,
#   url: "https://www.nytimes.com/2024/08/12/health/alcohol-cancer-heart-disease.html",
#   score: 1,
#   title: "Older Adults Do Not Benefit from Moderate Drinking, Large Study Finds",
#   story_type: "story",