Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  root to: 'pages#home'

  resources :stories do
    resource :star, only: [:create, :destroy], controller: 'stars'
  end

  get "starred_stories", to: "pages#starred_stories", as: 'starred_stories'
  post "starred_story_ids", to: "pages#starred_story_ids", as: 'starred_story_ids'
end
