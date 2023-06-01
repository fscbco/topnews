Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get '/news', to: 'news#index'

  resources :articles do
    post '/upvote', to: 'upvotes#create', as: :upvote
  end
end
