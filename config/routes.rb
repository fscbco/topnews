Rails.application.routes.draw do
  devise_for :users
  root to: 'news#index'
  post '/like_story/:id', to: 'news#like_story', as: 'like_story'
end
