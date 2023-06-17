Rails.application.routes.draw do
  devise_for :users
  get 'sign_out', to: 'users#sign_out'

  resources :home do
    member do
      patch :update_role
    end
  end
  
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
