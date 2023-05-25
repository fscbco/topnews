Rails.application.routes.draw do
  root to: 'stories#index'

  devise_for :users, skip: :registrations

  

  devise_scope :users do
    get "/users/sign_out" => "devise/sessions#destroy"
  end

  # resources :stories do
  #   member do
  #     post "upvote", to: "stories#upvote"
  #   end
  # end

  authenticate :user do
    get 'stories', to: 'stories#index'
    post "upvote", to: "stories#upvote"
    #post "like", to: "stories#upvote"
    # post 'stories/like', to: 'stories#like'
    # get 'likedstories', to: 'stories#liked_stories'
    #get '/story/:id', to: 'stories#show', as: :story
   # post '/stories/upvote', to: 'stories#upvote'
    # delete '/like/:id', to: 'stories#unlike', as: :unlike
  end
end
