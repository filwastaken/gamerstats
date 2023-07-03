class AdminController < ApplicationController
  before_action :authenticate_admin!

  # GET /adminpage or /admin.json
  def adminpage
    @savedusers = User.all
    @savedteams = Team.all
    @notification = Notification.new
  end

  # DELETE /adminpage#delete_team
  def delete_team
    Team.find(params[:id]).destroy
    redirect_to adminpage_path
  end

  # DELETE /adminpage#delete_user
  def delete_user
    User.find(params[:id]).destroy
    redirect_to adminpage_path
  end

  # POST /adminpage#gift
  def gift
    user = User.find(params[:id])

    if user.teamLeader?
      user.teamLeaderAbbonato!
    elsif user.user?
      user.abbonato!
    end

    redirect_to adminpage_path
  end

  # POST /adminpage#start_mainstanace
  def start_maintenance
    Maintenance.create!( from: DateTime.now )
    redirect_to adminpage_path
  end

  # POST /adminpage#stop_maintanace
  def stop_maintenance
    m = Maintenance.find_by(to: nil)
    m.to = DateTime.now
    m.save
    redirect_to adminpage_path
  end
end