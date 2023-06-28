Rails.application.routes.draw do
  
  # devide routes
  devise_for :admins
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  # resources routes
  resources :stats
  resources :teams

  
  get '/teams/:id/destroy', to: 'teams#destroy', as: 'destroy_team'
 
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  devise_scope :admin do
    get '/admins/sign_out' => 'devise/sessions#destroy'
  end

  resources :home do
    member do
      patch :update_role
    end
  end
  
  get '/personstats', to: 'home#personstats'

  # Admin routes
  get '/adminpage', to: 'admin#adminpage'
  delete '/adminpage/:id/delete_team', to: 'admin#delete_team', as: 'delete_team_admin'
  delete '/adminpage/:id/delete_user', to: 'admin#delete_user', as: 'delete_user_admin'

  root 'home#index'
  
  #get '/auth/:provider/callback', to: 'session#create'
  #get '/auth/failure' => 'session#fail'
  #get '/session/destroy' => 'session#destroy'
  #get '/session/create' => 'session#create'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'


end
