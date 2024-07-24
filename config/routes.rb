Rails.application.routes.draw do
  resources :news_items, only: [:index, :create]
  devise_for :users
  root to: 'pages#home'
end
