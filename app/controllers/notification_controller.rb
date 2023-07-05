class NotificationController < ApplicationController
  before_action :authenticate_admin!, only: [:adminnotification]

  def notification

    @notification = []
    Notification.all.each do |n|
      if n.to == Notification::DEFAULT_CASES[:toall] || (current_admin != nil && (n.to == Notification::DEFAULT_CASES[:toadmins] || current_admin.id == n.to)) || (current_user != nil && current_user.id == n.to && n.isuser)
        @notification.append(n)
      end
    end
  end

  # POST /adminpage#notification
  def adminnotification
    @notification = Notification.new
    @notification.body = params[:notification][:body]
    @notification.from = params[:id]
    @notification.to = params[:notification][:to].split("|")[0].to_i
    @notification.isuser = params[:notification][:to].split("|")[1]

    if(@notification.body != "")
      @notification.save

      if @notification.to == Notification::DEFAULT_CASES[:toall]
        User.update_all(bell: true)
        Admin.update_all(bell: true)
      elsif @notification.to == Notification::DEFAULT_CASES[:toadmins]
        Admin.update_all(bell: true)
      else
        if @notification.isuser?
          to_user = User.find(@notification.to)
          to_user.bell = true
          to_user.save
        else
          to_admin = Admin.find(@notification.to)
          to_admin.bell = true
          to_admin.save
        end
      end
      flash[:notice] = "La comunicazione è stata inviata correttamente"
      redirect_to adminpage_path
    else
      flash[:notice] = "Non puoi inviare una comunicazione vuota!"
      redirect_to adminpage_path
    end
    return
  end
end