Rails.application.routes.draw do
  resources :preferitos
  resources :stats
  resources :teams

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  get '/teams/:id/destroy', to: 'teams#destroy', as: 'destroy_team'
 
  get '/preferitos/:id/destroy', to: 'preferitos#destroy', as: 'destroy_preferitos'

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  patch '/teams/:id/abbandona', to: 'teams#abbandona', as: 'abbandona_team'

  resources :home do
    member do
      patch :update_role
    end
  end
  
  get '/personstats', to: 'home#personstats'
  root 'home#index'
  
  #get '/auth/:provider/callback', to: 'session#create'
  #get '/auth/failure' => 'session#fail'
  #get '/session/destroy' => 'session#destroy'
  #get '/session/create' => 'session#create'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'


end
