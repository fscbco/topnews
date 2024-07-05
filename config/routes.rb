Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: redirect('/stories/top'), as: :authenticated_root
  end

  unauthenticated do
    root to: redirect('/users/sign_in'), as: :unauthenticated_root
  end

  resources :stories, only: [] do
    collection do
      get 'top'
      get 'starred'
    end

    member do
      post 'star'
      post 'unstar'
    end
  end
end
