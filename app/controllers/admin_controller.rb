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
    
    team = Team.find(params[:id])

    # Notification in case everything works out
    body = "L'admin #{current_admin.nickname} ha eliminato il team #{team.nome_team} di cui facevi parte."

    if team.giocatore1 != ""
      to_user = User.find_by(uid: team.giocatore1)
    
      notification = Notification.new
      notification.from = current_admin.id
      notification.to = to_user.id
      notification.touser = true
      notification.body = body
      notification.save
              
      to_user.bell = true
      to_user.save
    end

    if team.giocatore2 != ""
      to_user = User.find_by(uid: team.giocatore2)
    
      notification = Notification.new
      notification.from = current_admin.id
      notification.to = to_user.id
      notification.touser = true
      notification.body = body
      notification.save
              
      to_user.bell = true
      to_user.save
    end
    
    if team.giocatore3 != ""
      to_user = User.find_by(uid: team.giocatore3)
    
      notification = Notification.new
      notification.from = current_admin.id
      notification.to = to_user.id
      notification.touser = true
      notification.body = body
              
      to_user.bell = true
      to_user.save
    end
    
    if team.giocatore4 != ""
      to_user = User.find_by(uid: team.giocatore4)
    
      notification = Notification.new
      notification.from = current_admin.id
      notification.to = to_user.id
      notification.touser = true
      notification.body = body
              
      to_user.bell = true
      to_user.save
    end

    team.destroy
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

    notification = Notification.new
    notification.body = "L'admin #{current_admin.nickname} ti ha regalato l'abbonamento🎉🍾"
    notification.from = current_admin.id
    notification.to = user.id
    notification.touser = true

    notification.save

    user.bell = true
    user.save

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