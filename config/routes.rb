Rails.application.routes.draw do
  devise_for :users
  resources :stories, only: [:index, :show]
  root to: 'pages#index'
end
