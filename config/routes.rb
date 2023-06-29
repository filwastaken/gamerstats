Rails.application.routes.draw do
  resources :stats
  resources :team_stats
  resources :teams

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  get '/teams/:id/destroy', to: 'teams#destroy', as: 'destroy_team'
 
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  get '/best_teams', to: 'teams#best_teams'
  get '/worst_teams', to: 'teams#worst_teams'

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
