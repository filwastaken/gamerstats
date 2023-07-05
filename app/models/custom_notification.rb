class CustomNotification
  attr_accessor :id, :email, :fromuser, :touser

  def initialize(id, email, touser)
    @id = id
    @email = email
    @touser = touser
  end
end