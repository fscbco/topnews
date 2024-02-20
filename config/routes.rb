Rails.application.routes.draw do
  devise_for :users
  resources :stories, only: [:index, :show, :destroy] do
    resources :recommendations, only: [:index, :create, :destroy]
  end

  get 'recommendations', to: 'pages#recommend', as: 'recommendations'
  post 'pages/:story_id/recommendations', to: 'recommendations#create', as: 'story_recommended'
  delete 'pages/:story_id/recommendations', to: 'recommendations#destroy', as: 'story_unrecommended'
  root to: 'pages#index'
end
