require 'uri'

class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :site_isusable
    before_action :set_cookie
  
    protected
    def set_cookie
      cookies.signed[:user_id] = current_user.id if current_user.present?
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    end
  
    def site_isusable
      if Maintenance.find_by(to: nil).equal? nil
        return
      end

      url = request.original_url

      if url.present?
        url = URI.parse(url)

        if url.path != root_path && url.path != adminpage_path && url.path != stop_maintenance_path && url.path != new_admin_session_path
          flash[:notice] = "Il sito e' al momento in manutenzione, alcune azioni non sono disponibili"
          redirect_to root_path
          return
        end
      end
    end
end
