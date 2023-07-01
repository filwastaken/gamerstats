# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
=begin
  def create
    BattlenetOauthService.ottieniProfilo(session[:access_token], params["user"]["uid"])
    if(Stat.find_by(uid: params["user"]["uid"]) == nil)
      flash[:notice] = "Non esiste un account con il seguente id: #{params["user"]["uid"]} nel gioco, inserire un altro id"
      redirect_to new_user_registration_path
      return
    end
    super
  end
=end

def authorization_code
  redirect_uri = 'http://localhost:3000/users/auth/bnet/callback'
  client_id = Rails.application.credentials.dig(:BNET_OAUTH_CLIENT_ID)
  scopes = 'openid'

  authorization_url = URI.parse('https://eu.battle.net/oauth/authorize')
  authorization_url.query = URI.encode_www_form(
    'response_type' => 'code',
    'client_id' => client_id,
    'redirect_uri' => redirect_uri,
    'scope' => scopes,
    'authenticity_token' => form_authenticity_token,
    'authenticity_token' => form_authenticity_token
  )

  redirect_to authorization_url.to_s

  authorization_code = session[:authorization_code]

  puts "$$$$$$$$$$$$$$$$$$$$$$"
  puts authorization_code
  puts "$$$$$$$$$$$$$$$$$$$$$$"
  if authorization_code == nil
    authorization_code
  else
    return authorization_code
  end
end

def access_token(authorization_code, csfr)
  uri = URI('https://oauth.battle.net/token')
  client_id = Rails.application.credentials.dig(:BNET_OAUTH_CLIENT_ID)
  client_secret = Rails.application.credentials.dig(:BNET_OAUTH_CLIENT_SECRET)
  redirect_uri = 'http://localhost:3000/users/auth/bnet/callback'
  scopes = 'openid'

  puts "-----------"
  puts authorization_code
  puts "-----------"

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = Net::HTTP::Post.new(uri.path)
  request.basic_auth(client_id, client_secret)
  request.set_form_data(
    'redirect_uri' => redirect_uri,
    'scope' => scopes,
    'grant_type' => 'authorization_code',
    'code' => authorization_code
  )
  request['X-CSRF-Token'] = csfr
  
  response = http.request(request)
  #puts "#############"
  #puts response.body
  #puts "#############"
  access_token = JSON.parse(response.body)["access_token"]
  return access_token
end

def userinfo(access_token, csfr)
  url = URI.parse("https://oauth.battle.net/oauth/userinfo")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = (url.scheme == "https")

  request = Net::HTTP::Get.new(url.path)
  request["Authorization"] = "Bearer #{access_token}"
  response = http.request(request)
  request['X-CSRF-Token'] = csfr
  
  body = JSON.parse(response.body)
  puts "______________________________"
  puts body
  puts "______________________________"
  return body
end

def create
  puts "INIZIOOOOOOOOOOOOOOOOOOOOO"
  if User.exists?(email: params[:user][:email])
    newuser = User.find_by(email: params["email"])
    flash[:notice] = "Hai già un account, devi effettuare il login"
    redirect_to '/users/sign_in'
    return
  else
    puts "°°°°°°°°°°°°°°°°"
    puts params.inspect
    puts "°°°°°°°°°°°°°°°°"
    csfr = params[:authenticity_token]
    if devise_mapping.omniauthable?
      resource_class.omniauth_providers.each do |provider|
          
        authorization_code = authorization_code()
        puts authorization_code

        access_token = access_token(authorization_code, csfr)
        puts access_token

        userinfo = userinfo(access_token, csfr)

  ##########################################################################################################

        if userinfo["error"] == nil
          profilo = {}
          
          tmp = BattlenetOauthService.ottieniIdGioco(access_token, userinfo["id"].to_i)
          puts "&&&&&&&&&&&&&&&&&&&"
          puts userinfo["id"].to_i
          puts tmp
          puts "&&&&&&&&&&&&&&&&&&&"
          if tmp.length != 0
            profilo = tmp
            session[:uid] = profilo["uid"]
            BattlenetOauthService.ottieniProfilo(access_token, profilo["uid"])
          else
            profilo["nome"] = ""
            profilo["idBattlenet"] = userinfo["id"]
            profilo["uid"] = -1
            session[:uid] = -1
          end

          if !User.exists?(uid: profilo["uid"])
            puts "ESISTEEEEEE"
            newuser = User.create!(
              email: params[:user][:email],
              password: params[:user][:password],
              created_at: Time.now,
              updated_at: Time.now,
              battlenetId: profilo["idBattlenet"],
              uid: profilo["uid"],
              nickname: profilo["nome"],
              role: 0,
            )
            sign_in(newuser, scope: :user)
          end
        end
      end
    end
  end
end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  def update_resource(resource, params)
    resource.update_with_password(params)
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
