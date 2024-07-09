Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get 'flagged_stories', to: 'stories#flagged_stories', as: 'flagged_stories'

  resources :stories do
    resource :flag, only: [:create, :destroy]
  end
end
