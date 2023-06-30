Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :stories, only: [:index, :show]
end
