Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "liked", to: "pages#liked_index", as: :liked_index
  post "like/:story_id", to: "pages#like_story", as: :like_story
end
