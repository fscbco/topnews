Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  authenticated :user do
    resources :pages, only: [:index, :show] do
      member do
        post 'upvote'
        post 'downvote'
      end
    end
  end
end
