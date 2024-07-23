Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :news, only: [:index]
end
