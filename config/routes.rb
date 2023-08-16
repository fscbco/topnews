Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: 'pages#home'

  get '/stories', to: 'stories#index'
  post '/stories', to: 'stories#create'
end
