Rails.application.routes.draw do
  get 'static_pages/help'
  get 'static_pages/home'

  resources :microposts
  resources :users

  get '/404', to: 'static_pages#error404', via: :all
  get '/500', to: 'static_pages#error500', via: :all

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'users#index'
  
end
