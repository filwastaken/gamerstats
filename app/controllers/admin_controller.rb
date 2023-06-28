class AdminController < ApplicationController
  # GET /admin or /admin.json
  def adminpage
    @savedusers = User.all
    @savedteams = Team.all
  end

  # DELETE /admin#delete_team
  def delete_team
    Team.find(params[:id]).destroy
    redirect_to "/adminpage"
  end

  # DELETE /admin#delete_user
  def delete_user
    User.find(params[:id]).destroy
    redirect_to "/adminpage"
  end

  # // TODO: Regala abbonamento
end
