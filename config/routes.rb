Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :news_details do
   collection do 
    get :liked_index
   end
    member do
      patch :upvote
      patch :downvote
      
    end
  end


end
