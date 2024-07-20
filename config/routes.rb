Rails.application.routes.draw do
  devise_for :users
  root to: 'hacker_news_stories#index'

  resources :hacker_news_stories, only: [:index]
  resources :hacker_news_recommendations, only: [:create, :destroy]
end
