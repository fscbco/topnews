Rails.application.routes.draw do
  devise_for :users
  resources :stories, only: [:index, :show, :destroy] do
    resources :recommendations, only: [:index, :create, :destroy]
  end

  get 'recommendations', to: 'pages#recommend', as: 'recommendations'
  root to: 'pages#index'
end
