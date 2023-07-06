class CustomNotification
  attr_accessor :id, :email, :fromUser, :toUser

  def initialize(id, email, toUser)
    @id = id
    @email = email
    @toUser = toUser
  end
end