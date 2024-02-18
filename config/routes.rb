Rails.application.routes.draw do
  devise_for :users
  resources :stories, only: [:index, :show] do
    resources :recommendations, only: [:index, :create, :destroy, :show]
  end
  root to: 'pages#index'
end
