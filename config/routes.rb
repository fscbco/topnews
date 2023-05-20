Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: redirect(path: '/news')
  get '/news', to: 'pages#news'
  devise_scope :user do
    root 'devise/sessions#new', as: :unauthenticated_root
  end
end

