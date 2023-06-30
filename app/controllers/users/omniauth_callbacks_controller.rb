# frozen_string_literal: true
require "securerandom"

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]
  #devise :omniauthable, omniauth_providers: [:bnet]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  def bnet
    auth = request.env['omniauth.auth']
    battletag = auth['info']['battletag']
    @user = User.from_omniauth(auth)

    if @user.present?
      session[:user] = @user
      session[:access_token] = auth["credentials"]["token"]
      ######
      profilo = {}
      tmp = BattlenetOauthService.ottieniIdGioco(session[:access_token], auth["uid"].to_i)
      
      if tmp.length != 0
        profilo = tmp
        session[:uid] = profilo["uid"]
      else
        profilo["nome"] = "-"
        profilo["idBattlenet"] = auth["uid"].to_i
        profilo["uid"] = -1
        session[:uid] = -1
      end
      ######
      sign_in_and_redirect @user, event: :authentication
      flash[:success] = t'devise.omniauth.callbacks.success', kind: 'Bnet'
    else
      session['devise.battle_net_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_path
      flash[:alert] = t'devise.omniauth.callbacks.failure', kind: 'Bnet', reason: "#{auth.info.email} is not authorized."
    end

    if !User.exists?(uid: profilo["uid"])
      newuser = User.create!(
        email: "#{profilo["idBattlenet"]}.placeholder@placeholder.com",
        password: "#{SecureRandom.alphanumeric(16)}",
        created_at: Time.now,
        updated_at: Time.now,
        battlenetId: profilo["idBattlenet"],
        uid: profilo["uid"],
        nickname: profilo["nome"],
        role: 0,
      )
    else
      newuser = User.find_by(uid: profilo["uid"])
    end

    sign_in(newuser, scope: :user)
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
