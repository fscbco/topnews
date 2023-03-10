Rails.application.routes.draw do
  resources :posts, only: %i[index]
  resources :favorites, only: %i[index create destroy]
  devise_for :users
  root to: 'posts#index'
end
