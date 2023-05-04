Rails.application.routes.draw do
  devise_for :users
  root to: 'top_stories#index'

  resources :top_stories
  resources :user_stories, only: [:create]
  resources :story_summaries, only: [:index]
end
