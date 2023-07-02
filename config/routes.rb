Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  post 'stars/star_article', to: 'stars#star_article', as: 'star_article'
end
