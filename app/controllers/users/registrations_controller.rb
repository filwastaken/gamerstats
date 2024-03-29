# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def loading_image
    send_file Rails.root.join('app', 'assets', 'images', 'loadingPiccola.gif'), type: 'image/gif', disposition: 'inline'
  end

  # GET /resource/sign_up
   def new
    if session[:battletag] == nil
      redirect_to root_path
    end
    @battletag = params[:battletag]
    @access_token = params[:access_token]
    @user = User.new
   end

  # POST /resource
  def create
    if session[:battletag] == nil
      redirect_to root_path
    else
      tmp = BattlenetOauthService.ottieniIdGioco(session[:access_token], session[:id].to_i)

      if params[:user][:password].length < 6
        flash[:notice] = "Password troppo corta! Scegline una piu' lunga"
        redirect_to new_user_registration_path
        return
      end

      if params[:user][:password] != params[:user][:password_confirmation]
        flash[:notice] = "Le password non corrispondono!"
        redirect_to new_user_registration_path
        return
      end

      if tmp.length != 0
        if User.find_by(email: params[:user][:email]) != nil
          flash[:notice] = "Email already taken"
          redirect_to new_user_registration_path
          return
        end

        newuser = User.create!(
          email: params[:user][:email],
          password: params[:user][:password],
          created_at: Time.current,
          updated_at: Time.current,
          battlenetId: tmp["idBattlenet"].to_i,
          uid: tmp["uid"].to_i,
          nickname: session[:battletag],
          role: 0, 
          bell: FALSE
        )
      else
        newuser = User.create!(
          email: params[:user][:email],
          password: params[:user][:password],
          created_at: Time.current,
          updated_at: Time.current,
          battlenetId: session[:id],
          uid: -1,
          nickname: session[:battletag],
          role: 0, 
          bell: FALSE
        )
      end
        sign_in(newuser, scope: :user)
        redirect_to root_path
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
