Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: redirect(path: '/news')
  get '/news', to: 'pages#news'
  # resources :news do
  #   member do
  #     patch :flag
  #   end
  # end
  patch '/news/:news_id/flag/:user_name', to: 'news#flag', as: 'flag_news'
  devise_scope :user do
    root 'devise/sessions#new', as: :unauthenticated_root
  end
end

