Rails.application.routes.draw do
  devise_for :users
  post 'pages/like/:id', to: 'pages#like'
  root to: 'pages#home'
end
