Rails.application.routes.draw do
  # resources :posts
  devise_for :users
  root to: 'pages#home'
  resources :posts do
    resources :likes
  end
  # resources :likes
  # get 'likes', to: 'likes#index'


end

