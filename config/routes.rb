Rails.application.routes.draw do
  devise_for :users

  resources :posts, only: %i[index]
  resources :stars, only: %i[create destroy]

  root to: 'posts#index'
end
