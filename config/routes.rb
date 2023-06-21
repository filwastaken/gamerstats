Rails.application.routes.draw do
  resources :teams
  devise_for :users
  
  
  get '/teams/:id/destroy', to: 'teams#destroy', as: 'destroy_team'
 
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  resources :home do
    member do
      patch :update_role
    end
  end
  
  get '/personstats', to: 'home#personstats'
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
