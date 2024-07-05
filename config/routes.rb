Rails.application.routes.draw do
  devise_for :users
  root to: redirect('/stories/top')

  resources :stories, only: [] do
    collection do
      get 'top'
    end

    member do
      post 'star'
      post 'unstar'
    end
  end
end
