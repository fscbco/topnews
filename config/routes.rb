Rails.application.routes.draw do
  devise_for :users
  root to: 'stories#index'
  resource :story_stars, only: [:create]
end
