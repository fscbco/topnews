require 'rest-client'

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  
  def index
    fetch_from_hacker_news() if ! defined?(@articles) || @articles.empty?
    @articles = Article.all
  end
  
  def show
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end
  

  private

  def set_article
    @article = Article.find(params[:id])
  end
  
  def article_params #bkao
    params.require(:article).permit(:title, :content, :bookmarked)
  end
  
  def fetch_from_hacker_news
    url = 'https://hacker-news.firebaseio.com/v0/topstories.json'
    response = RestClient.get(url)
    stories = JSON.parse(response.body)[0..10] # fixme
    
    stories.each do |story_id|
      response = RestClient.get("https://hacker-news.firebaseio.com/v0/item/#{story_id}.json")
      item = JSON.parse(response.body)
      
      # Assuming the item contains keys for title, url, and author
      # next unless item['title'] && item['url']
      begin      
        Article.create!(
          author: item['by'],
          descendants: item['descendants'],
          article_id: item['id'],
          kids: item['kids'],
          score: item['score'],
          time: item['time'],
          title: item['title'],
          type: item['type'],
          url: item['url'],
          content: "lorem ipsum",
          bookmarked: false,
          user_type: "",
          user_id: ""
        )
      rescue
      end
    end
  end
  
end
