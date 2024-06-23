Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :stories do
    member do
      post "flag"
    end
  end
end
