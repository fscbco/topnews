Rails.application.routes.draw do
  root to: 'stories#index'

  devise_for :users, skip: :registrations

  

  devise_scope :users do
    get "/users/sign_out" => "devise/sessions#destroy"
  end

  authenticate :user do
    get 'stories', to: 'stories#index'
    post "upvote", to: "stories#upvote"
  end
end
