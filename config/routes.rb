Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  put 'pages/:id/like', to: 'pages#like', as: 'like'
end
