Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'recommendations', to: 'pages#recommendations'
  resources :recommendations, only: [:create]
end
