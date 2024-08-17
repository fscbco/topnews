class UserArticlesController < ApplicationController
  def index
    @user_articles = UserArticle.includes(:user, :article)
  end

  def create
    @article_created = false
    @user_article_created = false

    params.required(:article).permit!
    article_attributes = params[:article]
    find_article_from_attributes(article_attributes)
    create_article_if_doesnt_exists(article_attributes)
    find_or_create_user_article

    head :created
  end

  private

  # TODO: Move this to before_action
  def find_article_from_attributes(article_attributes)
    @article = nil
    if article_attributes.key?("id") && article_attributes["id"].present?
      @article = Article.where(id: article_attributes["id"]).first
    elsif article_attributes.key?("external_id") && article_attributes["external_id"].present?
      @article = Article.where(external_id: article_attributes["external_id"]).first
    end
  end

  # TODO: Move this to before_action
  def create_article_if_doesnt_exists(article_attributes)
    return if @article
    @article ||= Article.create(article_attributes)
    @article_created = true
  end

  # TODO: Move this to before_action
  def find_or_create_user_article
    return unless @article
    @user_article = UserArticle.where(user: current_user, article: @article).first
    unless @user_article
      @user_article = UserArticle.create(user: current_user, article: @article)
      @user_article_created = true
    end
  end
end
