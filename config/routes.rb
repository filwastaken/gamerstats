Rails.application.routes.draw do
  resources :stats
  devise_for :users, controllers: {
    registrations: 'user/registrations',
    session: 'user/session',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'pages#home'
  
  #get '/auth/:provider/callback', to: 'session#create'
  #get '/auth/failure' => 'session#fail'
  #get '/session/destroy' => 'session#destroy'
  #get '/session/create' => 'session#create'
end
