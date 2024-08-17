Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get "/articles", to: "articles#index"
  get "/user_articles", to: "user_articles#index"
  post "/user_articles", to: "user_articles#create"
end
