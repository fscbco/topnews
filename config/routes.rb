Rails.application.routes.draw do
  devise_for :users
  root to: 'news#index'
  resources :user_stories, only: [:index, :create]
end
