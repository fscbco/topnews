Rails.application.routes.draw do
  resources :picks
  resources :flagged_stories
  post 'flagged_stories' => "flagged_stories#create", :as => :create_flagged_stories


  root to: 'pages#home'
  get '/news', to: 'news#index'
  devise_for :users
end
