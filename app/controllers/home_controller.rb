class HomeController < ApplicationController
  def index
  end

  def update_role
    @user = User.find(params[:id])
    @user.role = params[:role]
    if @user.save
      redirect_to home_index_path, notice: 'Il ruolo è stato aggiornato con successo. '
    else
      render :edit, alert: 'Si è verificato un errore durante l\'aggiornamento del ruolo.'
    end
  end
end
