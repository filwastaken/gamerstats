class CustomNotification
  attr_accessor :id, :email, :isuser

  def initialize(id, email, isuser)
    @id = id
    @email = email
    @isuser = isuser
  end
end