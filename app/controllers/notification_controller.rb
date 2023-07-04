class NotificationController < ApplicationController
  before_action :authenticate_admin!, only: [:adminnotification]

  def notification
    @notification = []
    Notification.all.each do |n|
      if n.to == Notification::DEFAULT_CASES[:toall] || (current_admin != nil && (n.to == Notification::DEFAULT_CASES[:toadmins] || current_admin.id == n.id)) || (current_user != nil && current_user.id == n.id && n.isuser)
        @notification.append(n)
      end
    end
  end

  # POST /adminpage#notification
  def adminnotification
    @notification = Notification.new
    @notification.body = params[:notification][:body]
    @notification.from = params[:id]
    @notification.to = params[:notification][:to]

    @notification.isuser = params[:notification][:isuser]
    @notification.save

    if @notification.to == Notification::DEFAULT_CASES[:toall]
      User.update_all(bell: true)
      Admin.update_all(bell: true)
    elsif @notification.to == Notification::DEFAULT_CASES[:toadmins]
      Admin.update_all(bell: true)
    else
      if @notification.isuser?
        User.find(@notification.to).bell = true
      else
        Admin.find(@notification.to).bell = true
      end
    end

    redirect_to adminpage_path
    return
  end

  def usernotification
    puts "Ciao"
  end
end