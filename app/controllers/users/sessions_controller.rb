# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  #def new
  #end

  # POST /resource/sign_in
  def create
    puts "ENTRAAAAAAAAAAAAAAAAAAAAAA"
    if(session[:access_token] == nil)
      session[:access_token] = BattlenetOauthService.ottieniAccessToken()
    end

    user = User.find_by(email: params[:user][:email])

    if user != nil
      if user.valid_password?(params[:user][:password])
        sign_in(user)
        self.resource = warden.set_user(user, scope: :user)
        redirect_to after_sign_in_path_for(user)
      else
        puts "ENTRA"
        flash.now[:alert] = 'Credenziali di accesso non valide.'
        self.resource = User.new
        render :new
      end
    else
      puts "NON ESISTE L'ACCOUNT"
      self.resource = User.new
    end

    puts "ESCEEEEEEEEEEEEEEEEEEEEEEE"
    #super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
