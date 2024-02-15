Rails.application.routes.draw do
  devise_for :users
  resources :stories, only: :index
  root to: 'pages#home'
end
