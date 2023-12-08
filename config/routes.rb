Rails.application.routes.draw do
  devise_for :users
  resource :stories, only: [:index]
  resource :likes, only: [:create]
  root to: 'stories#index'

end
