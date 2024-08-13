Rails.application.routes.draw do
  devise_for :users, only: [:sessions]
  root to: 'news_details#index'

  resources :news_details, only: [:index] do
    collection do
      get :liked_index
    end
    member do
      patch :upvote
      patch :downvote
    end
  end
end
