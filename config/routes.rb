Rails.application.routes.draw do
  devise_for :users
  root to: 'stories#index'

  resources :stories, only: [:index] do
    post 'flag', on: :member
  end


  get '/top_stories', to: 'pages#top_stories'

end
