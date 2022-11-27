Rails.application.routes.draw do
  devise_for :users
  resources :users do
    resources :favorites, only: [:new, :create]
  end
  root to: 'pages#home'
end
