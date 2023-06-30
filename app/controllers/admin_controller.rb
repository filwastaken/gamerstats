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

  # POST /admin#gift
  def gift
    user = User.find(params[:id])

    if user.teamLeader?
      user.teamLeaderAbbonato!
    elsif user.user?
      user.abbonato!
    end

    redirect_to "/adminpage"
  end
  
  # POST /admin#comunication
  def comunication

    User.all.each do |users|
      users.bell = true
    end

    Admin.all.each do |admin|
      admin.bell = true
    end

  end
end
