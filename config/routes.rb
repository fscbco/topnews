Rails.application.routes.draw do
  devise_for :users
  root to: "stories#index"

  resources :stories, only: [:index, :show] do
    resources :likes, only: [:create], controller: "stories/likes"
  end
end
