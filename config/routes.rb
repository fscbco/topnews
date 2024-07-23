Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # resource :favorite, only: [:create, :destroy]

  post '/favorite', to: 'favorites#create', as: :favorite_create
  delete '/favorite', to: 'favorites#destroy', as: :favorite_destroy

end
