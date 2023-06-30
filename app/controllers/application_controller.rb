class ApplicationController < ActionController::Base
    # app/controllers/application_controller.rb
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :full_name])
    end
  
end
