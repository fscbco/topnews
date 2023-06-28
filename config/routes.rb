Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resource :user_stories, only: [:create, :destroy]
end
