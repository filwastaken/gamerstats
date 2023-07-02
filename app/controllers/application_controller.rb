require 'uri'

class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :site_isusable
  
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
      devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
    end
  
    def site_isusable
      if Maintenance.find_by(to: nil).equal? nil
        return
      end

      url = request.original_url

      if url.present?
        url = URI.parse(url)

        if url.path != '/' && url.path != "/adminpage" && url.path != "/adminpage/stop_maintenance" && url.path != "/admins/sign_in"
          redirect_to root_path
        end
      end
    end
end
