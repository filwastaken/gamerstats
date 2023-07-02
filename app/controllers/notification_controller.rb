class NotificationController < ApplicationController
  def notification

    @notification = []
    Notification.all.each do |n|
      if n.to == Notification::DEFAULT_CASES[:toall] || (current_admin != nil && (n.to == Notification::DEFAULT_CASES[:toadmins] || current_admin.id == n.id)) || (current_user != nil && current_user.id == n.id && n.isuser)
        @notification.append(n)
      end
    end
  end
end