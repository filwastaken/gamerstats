class AdminController < ApplicationController
  before_action :authenticate_admin!

  # GET /adminpage or /admin.json
  def adminpage
    @savedusers = User.all
    @savedteams = Team.all
    @notification = Notification.new

    @merged_collection = [CustomNotification.new(Notification::DEFAULT_CASES[:toall], 'Everyone', false), CustomNotification.new(Notification::DEFAULT_CASES[:toadmins], 'Every Admins', false)]
    Admin.where.not(id: current_admin.id).each do |admin|
      @merged_collection.append(CustomNotification.new(admin.id, admin.email, false))
    end
    User.all.each do |user|
      @merged_collection.append(CustomNotification.new(user.id, user.email, true))
    end
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
      notification.toUser = true
      notification.body = body
      notification.save
              
      to_user.bell = true
      to_user.save
    end

    if team.giocatore2 != ""
      to_user = User.find_by(uid: team.giocatore2)
      if to_user != nil
        notification = Notification.new
        notification.from = current_admin.id
        notification.to = to_user.id
        notification.toUser = true
        notification.body = body
        notification.save
                
        to_user.bell = true
        to_user.save
      end
    end
    
    if team.giocatore3 != ""
      to_user = User.find_by(uid: team.giocatore3)
    
      if to_user != nil
        notification = Notification.new
        notification.from = current_admin.id
        notification.to = to_user.id
        notification.toUser = true
        notification.body = body
                
        to_user.bell = true
        to_user.save
      end
    end
    
    if team.giocatore4 != ""
      to_user = User.find_by(uid: team.giocatore4)
    
      if to_user != nil
        notification = Notification.new
        notification.from = current_admin.id
        notification.to = to_user.id
        notification.toUser = true
        notification.body = body
                
        to_user.bell = true
        to_user.save
      end
    end

    team.destroy
    flash[:notice] = "Team eliminato con successo."
    redirect_to adminpage_path
  end

  # DELETE /adminpage#delete_user
  def delete_user
    Notification.where(to: params[:id]).destroy_all

    User.find(params[:id]).destroy

    flash[:notice] = "Utente eliminato con successo."
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
    notification.toUser = true

    notification.save

    user.bell = true
    user.save

    flash[:notice] = "Regalo inviato con successo!"
    redirect_to adminpage_path
  end

  # POST /adminpage#start_mainstanace
  def start_maintenance
    Maintenance.create!( from: DateTime.now )
    flash[:notice] = "Manutenzione iniziata con successo."
    redirect_to adminpage_path
  end

  # POST /adminpage#stop_maintanace
  def stop_maintenance
    m = Maintenance.find_by(to: nil)
    m.to = DateTime.now
    m.save
    flash[:notice] = "Manutenzione interrotta con successo."
    redirect_to adminpage_path
  end
end