Rails.application.routes.draw do
  devise_for :users
  #root to: 'pages#home'

  resources :logins, only: [:new, :create, :destroy]

  resources :news, only: [:get, :post]
  post '/news/star', to: 'news#star'
  post '/news/unstar', to: 'news#unstar'
  root to: 'news#index'
end
