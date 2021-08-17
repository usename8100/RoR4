Rails.application.routes.draw do
  get 'sessions/new'
  get 'static_pages/help'
  get 'static_pages/home'
  get 'static_pages/not_found'
  get 'static_pages/internal_server_error'

  resources :microposts
  resources :users

  get '/404', to: 'static_pages#not_found', via: :all
  get '/500', to: 'static_pages#internal_server_error', via: :all
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  
end
