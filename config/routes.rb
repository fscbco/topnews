Rails.application.routes.draw do
  devise_for :users

  resources :stories, only: %i[index]
  post 'stories/:id/like', to: 'stories#like', as: 'like_story'
  root to: 'stories#index'
end
