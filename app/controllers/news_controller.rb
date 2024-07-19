class NewsController < ApplicationController
  # before_action :require_login
  helper_method :current_user

  def index
  	all_articles = Article.where(hn_time: 7.days.ago..).limit(100)
  	@articles = []
  	@articles, @team_articles = all_articles.partition { |article| article.users.empty? } 
  	@my_articles, @team_articles = @team_articles.partition { |article| article.users.pluck(:id).include?(current_user.id) } 
    # Cap this
  	@articles = @articles.slice(0, 50)
  end

  def star
  	id = params["id"]
  	Rails.logger.info(id)
  	return unless id
  	return unless current_user
  	a = Article.find(id)
  	a.users << current_user
  	# a.save!
  end

  def unstar
  	id = params["id"]
  	Rails.logger.info(id)
  	return unless id
  	return unless current_user
  	a = Article.find(id)
  	a.users.delete(current_user)
  end

  #def current_user
  	# @current_user = User.first
  #  @current_user ||= User.find(session[:current_user_id]) if session[:current_user_id]
  #end
end
