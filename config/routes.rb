Rails.application.routes.draw do
  devise_for :users

  resources :stories, only: [:index] do
    post 'mark_interesting', on: :member
  end

  resources :interesting_stories, only: [:index]

  # Define a named route for top stories
  get 'top_stories', to: 'stories#index', as: 'top_stories'

  root to: "stories#index"

end