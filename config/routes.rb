Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: redirect(path: '/news')
  get '/news', to: 'pages#news'
  patch '/news/:news_id/flag/:user_name', to: 'news#flag', as: 'flag_news'
  devise_scope :user do
    root 'devise/sessions#new', as: :unauthenticated_root
  end
end

