Rails.application.routes.draw do
  resources :items do
    member do
      patch :vote
    end
  end
  
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  devise_for :users
  root to: 'items#index'
end
