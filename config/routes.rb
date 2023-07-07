Rails.application.routes.draw do
  root 'home#index'
  get '/search', to: 'home#search'

  get '/teams/assets/loadingPiccola.gif', to: 'teams#loading_image'
  get '/teams/:id/assets/loadingPiccola.gif', to: 'teams#loading_image', as: 'team_loading_image'
  get '/preferitos/assets/loadingPiccola.gif', to: 'preferitos#loading_image'
  get '/preferitos/:id/assets/loadingPiccola.gif', to: 'preferitos#loading_image', as: 'preferito_loading_image'

  # resources routes
  resources :preferitos
  resources :stats
  resources :team_stats
  resources :teams

  # devise routes
  devise_for :admins
  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  put 'users' => 'user/registrations#update'

  get '/teams/:id/destroy', to: 'teams#destroy', as: 'destroy_team'
 
  get '/preferitos/:id/destroy', to: 'preferitos#destroy', as: 'destroy_preferitos'

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'   
  end

  devise_scope :admin do
    get '/admins/sign_out' => 'devise/sessions#destroy'
    get '/users/assets/loadingPiccola.gif', to: 'users/registrations#loading_image'
  end

  get '/best_teams', to: 'teams#best_teams'
  get '/worst_teams', to: 'teams#worst_teams'

  patch '/teams/:id/abbandona', to: 'teams#abbandona', as: 'abbandona_team'

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
  post '/adminpage/:id/gift', to: 'admin#gift', as: 'gift_admin'
  post '/adminpage/:id/notification', to: 'notification#adminnotification', as: 'adminnotification'
  post '/adminpage/start_maintenance', to: 'admin#start_maintenance', as: 'start_maintenance'
  post '/adminpage/stop_maintenance', to: 'admin#stop_maintenance', as: 'stop_maintenance'
  
  # Notification routes
  get '/notification', to: 'notification#notification', as: 'view_notification'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'


end
