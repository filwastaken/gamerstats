# frozen_string_literal: true
require "securerandom"

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :bnet
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]
  #devise :omniauthable, omniauth_providers: [:bnet]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

def bnet
  auth = request.env['omniauth.auth']

  battletag = auth['info']['battletag']
  access_token = auth['credentials']['token']
  battlenetid = auth["uid"]

  session[:battletag] = battletag
  session[:access_token] = access_token
  session[:id] = battlenetid

  if User.exists?(battlenetId: battlenetid)
    newuser = User.find_by(battlenetId: battlenetid)
    sign_in(newuser, scope: :user)
    redirect_to root_path
  else
    redirect_to new_user_registration_path
  end
end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  protected

  def after_omniauth_failure_path_for(_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end 

  private 

  def auth
    @auth ||= request.env['omniauth.auth']
  end

end
